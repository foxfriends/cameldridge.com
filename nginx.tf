resource "docker_image" "nginx" {
  name = "nginx"
}

resource "terraform_data" "nginx_config" {
  input = sha1(join("", [for f in fileset("${path.module}/nginx/templates", "*") : filesha1("${path.module}/nginx/templates/${f}")]))
}

resource "docker_container" "nginx" {
  image   = docker_image.nginx.image_id
  name    = "nginx"
  restart = "unless-stopped"

  ports {
    internal = 80
    external = 80
  }

  ports {
    internal = 443
    external = 443
  }

  volumes {
    container_path = "/etc/nginx/templates"
    host_path      = abspath("${path.module}/nginx/templates")
    read_only      = true
  }

  volumes {
    container_path = "/ssl/"
    host_path      = abspath("${path.module}/nginx/ssl")
    read_only      = true
  }

  network_mode = "bridge"

  networks_advanced {
    name = data.docker_network.bridge.id
  }

  networks_advanced {
    name = docker_network.cookiealyst_ingress.id
  }

  networks_advanced {
    name = docker_network.conartist_ingress.id
  }

  networks_advanced {
    name = docker_network.inventory_ingress.id
  }

  networks_advanced {
    name = docker_network.mahjong_ingress.id
  }

  networks_advanced {
    name = docker_network.machi_koro_ingress.id
  }

  networks_advanced {
    name = docker_network.tokaido_ingress.id
  }

  networks_advanced {
    name = docker_network.catan_ingress.id
  }

  networks_advanced {
    name = docker_network.jef_ingress.id
  }

  env = [
    "COOKIEALYST_HOST=${module.cookiealyst.name}",
    "COOKIEALYST_PORT=${module.cookiealyst.container_port}",
    "INVENTORY_HOST=${module.inventory.name}",
    "INVENTORY_PORT=${module.inventory.container_port}",
    "CONARTIST_HOST=${module.conartist.name}",
    "CONARTIST_PORT=${module.conartist.container_port}",
    "MAHJONG_HOST=${module.mahjong.name}",
    "MAHJONG_PORT=${module.mahjong.container_port}",
    "MACHI_KORO_HOST=${module.machi-koro.name}",
    "MACHI_KORO_PORT=${module.machi-koro.container_port}",
    "TOKAIDO_HOST=${module.tokaido.name}",
    "TOKAIDO_PORT=${module.tokaido.container_port}",
    "CATAN_HOST=${module.catan.name}",
    "CATAN_PORT=${module.catan.container_port}",
    "JEF_HOST=${module.jef.name}",
    "JEF_PORT=${module.jef.container_port}",
    # HACK: for nginx templating via envsubst, we "escape" the $ as ${DOLLAR}
    "DOLLAR=$",
  ]

  lifecycle {
    replace_triggered_by = [
      terraform_data.nginx_config
    ]
  }
}
