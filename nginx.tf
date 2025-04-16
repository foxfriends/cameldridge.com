resource "docker_image" "nginx" {
  name = "nginx"
}

resource "docker_container" "nginx" {
  image   = docker_image.nginx.image_id
  name    = "cameldridge.com"
  restart = "unless-stopped"

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
    "MAHJONG_PORT=${module.mahjong.port}",
    "MACHI_KORO_PORT=${module.machi-koro.port}",
    # HACK: for nginx templating via envsubst, we "escape" the $ as ${DOLLAR}
    "DOLLAR=$",
  ]
}
