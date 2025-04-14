module "discord-gacha" {
  source = "git@github.com:foxfriends/discord-gacha//terraform/modules/docker"

  name = "discord-gacha"

  assets_dir    = abspath("${path.module}/discord-gacha/assets")
  products_file = abspath("${path.module}/discord-gacha/products.toml")

  discord_application_id = "1209186008860725269"
  discord_token          = var.discord_token

  sheets_sheet_id      = "1jt-RDUtGk39aGQ3yldytknp9ssNGZljqApmHGmK2piU"
  sheets_client_id     = "288536811089-2v26mpfb1d2kvb00ktnvo133erp0ojoh.apps.googleusercontent.com"
  sheets_client_secret = var.sheets_client_secret
  sheets_access_token  = var.sheets_access_token
  sheets_refresh_token = var.sheets_refresh_token
  # NOTE: this is a fake URL
  sheets_redirect_uri = "https://gacha.cameldridge.com/google/oauth"

  shopify_shop  = "kittyalyst"
  shopify_token = var.shopify_token

  inventory_url = "https://inventory.cameldridge.com"
}
