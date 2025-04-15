resource "docker_image" "nginx" {
  name = "nginx"
}

resource "docker_container" "nginx" {
  image   = docker_image.nginx.image_id
  name    = "cameldridge.com"
  restart = "unless-stopped"

  ports {
    internal = 80
    external = 80
  }

  ports {
    internal = 443
    external = 443
  }

  network_mode = "host"

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

  env = [
    "COOKIEALYST_PORT=${module.cookiealyst.port}",
    "INVENTORY_PORT=${module.inventory.port}",
    "CONARTIST_PORT=${module.conartist.port}",
    # HACK: for nginx templating via envsubst, we "escape" the $ as ${DOLLAR}
    "DOLLAR=$",
  ]
}
