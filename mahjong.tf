resource "docker_network" "mahjong_ingress" {
  name     = "mahjong-ingress"
  driver   = "bridge"
  internal = true
}

module "mahjong" {
  source = "github.com/foxfriends/mahjong//terraform/modules/docker"

  name   = "mahjong"
  expose = false

  networks = [{
    name = docker_network.mahjong_ingress.id
  }]
}
