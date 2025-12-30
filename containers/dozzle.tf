resource "docker_network" "dozzle_ingress" {
  name     = "dozzle-ingress"
  driver   = "bridge"
  internal = true
}

resource "docker_image" "dozzle" {
  name = "amir20/dozzle"
}

resource "docker_container" "dozzle" {
  image   = docker_image.dozzle.image_id
  name    = "dozzle"
  restart = "unless-stopped"

  volumes {
    container_path = "/var/run/docker.sock"
    host_path      = "/var/run/docker.sock"
  }

  network_mode = "bridge"

  networks_advanced {
    name = docker_network.dozzle_ingress.id
  }

  env = [
    "DOZZLE_ENABLE_ACTIONS=false",
    "DOZZLE_ENABLE_SHELL=false",
    "DOZZLE_HOSTNAME=cameldridge.com",
    "DOZZLE_NO_ANALYTICS=true",
  ]
}
