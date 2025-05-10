resource "docker_network" "jef_ingress" {
  name     = "jef-ingress"
  driver   = "bridge"
  internal = true
}

module "jef" {
  source = "github.com/foxfriends/jef//terraform/modules/docker"

  name   = "jef"
  expose = false

  base_url = "https://jef.cameldridge.com"

  well_known_dir = "${path.module}/jef/.well-known"

  discord_application_id = var.jef_discord_application_id
  discord_public_key     = var.jef_discord_public_key
  discord_client_secret  = var.jef_discord_client_secret
  discord_bot_token      = var.jef_discord_bot_token

  shopify_client_id     = var.jef_shopify_client_id
  shopify_client_secret = var.jef_shopify_client_secret

  networks = [{
    name = docker_network.jef_ingress.name
  }]
}
