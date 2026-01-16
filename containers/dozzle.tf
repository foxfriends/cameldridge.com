resource "docker_network" "dozzle_ingress" {
  name     = "dozzle-ingress"
  driver   = "bridge"
  internal = true
}

resource "docker_image" "dozzle" {
  name = "amir20/dozzle:latest"
}

resource "docker_container" "dozzle" {
  image   = docker_image.dozzle.image_id
  name    = "dozzle"
  restart = "unless-stopped"
  command = ["agent"]

  volumes {
    container_path = "/var/run/docker.sock"
    host_path      = "/var/run/docker.sock"
    read_only      = true
  }

  ports {
    internal = 7007
    external = 7007
  }

  network_mode = "bridge"

  networks_advanced {
    name = data.docker_network.bridge.id
  }

  env = [
    "DOZZLE_ENABLE_ACTIONS=false",
    "DOZZLE_ENABLE_SHELL=false",
    "DOZZLE_HOSTNAME=cameldridge.com",
    "DOZZLE_NO_ANALYTICS=true",
  ]
}
