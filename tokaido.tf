resource "docker_network" "tokaido_ingress" {
  name     = "tokaido-ingress"
  driver   = "bridge"
  internal = true
}

module "tokaido" {
  source = "github.com/foxfriends/tokaido//terraform/modules/docker"

  name   = "tokaido"
  expose = false

  networks = [{
    name = docker_network.tokaido_ingress.id
  }]
}
