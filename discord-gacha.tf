module "discord-gacha" {
  source = "github.com/foxfriends/discord-gacha//terraform/modules/docker"

  name = "discord-gacha"

  assets_dir    = abspath("${path.module}/discord-gacha/assets")
  products_file = abspath("${path.module}/discord-gacha/products.toml")

  discord_application_id = var.gacha_discord_application_id
  discord_token          = var.gacha_discord_token

  sheets_sheet_id      = var.gacha_sheets_sheet_id
  sheets_client_id     = var.gacha_sheets_client_id
  sheets_client_secret = var.gacha_sheets_client_secret
  sheets_refresh_token = var.gacha_sheets_refresh_token
  sheets_redirect_uri  = var.gacha_sheets_redirect_uri

  shopify_shop  = var.gacha_shopify_shop
  shopify_token = var.gacha_shopify_token

  inventory_url = "https://inventory.cameldridge.com"
}
