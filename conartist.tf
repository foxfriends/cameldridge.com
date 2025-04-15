module "conartist" {
  source = "github.com/foxfriends/conartist//terraform/modules/docker"

  name = "conartist"

  conventions_dir = abspath("${path.module}/conartist/conventions")

  base_url     = "conartist.aop"
  server_email = "hello@conartist.app"

  mailgun_username = var.conartist_mailgun_username
  mailgun_password = var.conartist_mailgun_password
  mailgun_api_key  = var.conartist_mailgun_api_key
}
