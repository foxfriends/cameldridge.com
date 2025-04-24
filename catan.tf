resource "docker_network" "catan_ingress" {
  name     = "catan-ingress"
  driver   = "bridge"
  internal = true
}

module "catan" {
  source = "github.com/foxfriends/catan//terraform/modules/docker"

  name   = "catan"
  expose = false
  networks = [{
    name = docker_network.inventory_ingress.name
  }]
}
