resource "docker_network" "cookiealyst_ingress" {
  name     = "cookiealyst-ingress"
  driver   = "bridge"
  internal = true
}

module "cookiealyst" {
  source = "github.com/foxfriends/cookiealyst//terraform/modules/docker"

  name   = "cookiealyst"
  expose = false

  data_dir   = abspath("${path.module}/cookiealyst/load")
  images_dir = abspath("${path.module}/cookiealyst/images")

  networks = [{
    name = docker_network.cookiealyst_ingress.name
  }]
}
