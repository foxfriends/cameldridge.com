resource "docker_image" "caddy" {
  name = "caddy"
}

resource "terraform_data" "caddy_config" {
  input = sha1(join("", [for f in fileset("${path.module}/caddy/conf", "*") : filesha1("${path.module}/caddy/conf/${f}")]))
}

resource "docker_container" "caddy" {
  image   = docker_image.caddy.image_id
  name    = "caddy"
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
    container_path = "/etc/caddy"
    host_path      = abspath("${path.module}/caddy/conf")
    read_only      = true
  }

  volumes {
    container_path = "/www/game/"
    host_path      = abspath("${path.module}/cameldridge/game")
    read_only      = true
  }

  volumes {
    container_path = "/www/cameldridge/"
    volume_name    = docker_volume.cameldridge.name
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
    name = docker_network.dozzle_ingress.id
  }

  env = [
    "COOKIEALYST_HOST_NAME=${var.cookiealyst_host_name}",
    "CONARTIST_HOST_NAME=${var.conartist_host_name}",
    "CAMELDRIDGE_HOST_NAME=${var.cameldridge_host_name}",
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
    "DOZZLE_HOST=${docker_container.dozzle.name}",
    "DOZZLE_PORT=8080",
  ]

  lifecycle {
    replace_triggered_by = [
      terraform_data.caddy_config
    ]
  }
}
