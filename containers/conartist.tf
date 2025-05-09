resource "docker_network" "conartist_ingress" {
  name     = "conartist-ingress"
  driver   = "bridge"
  internal = true
}

module "conartist" {
  source = "github.com/foxfriends/conartist//terraform/modules/docker"

  name   = "conartist"
  expose = false

  conventions_dir = abspath("${path.module}/conartist/conventions")

  base_url     = "conartist.app"
  server_email = "hello@conartist.app"

  mailgun_username = var.conartist_mailgun_username
  mailgun_password = var.conartist_mailgun_password
  mailgun_api_key  = var.conartist_mailgun_api_key

  networks = [{
    name = docker_network.conartist_ingress.id
  }]
}
