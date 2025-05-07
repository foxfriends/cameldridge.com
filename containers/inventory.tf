resource "docker_network" "inventory_ingress" {
  name     = "inventory-ingress"
  driver   = "bridge"
  internal = true
}

module "inventory" {
  source = "github.com/foxfriends/inventory//terraform/modules/docker"

  name       = "inventory"
  expose     = false
  config_dir = abspath("${path.module}/inventory/config")
  networks = [{
    name = docker_network.inventory_ingress.name
  }]
}
