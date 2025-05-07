resource "docker_network" "machi_koro_ingress" {
  name     = "machi-koro-ingress"
  driver   = "bridge"
  internal = true
}

module "machi-koro" {
  source = "github.com/foxfriends/machi-koro//terraform/modules/docker"

  name   = "machi-koro"
  expose = false

  networks = [{
    name = docker_network.machi_koro_ingress.id
  }]
}
