variable "cameldridge_host_name" {
  type    = string
  default = "cameldridge.com"
}

variable "cookiealyst_host_name" {
  type    = string
  default = "cookiealyst.com"
}

variable "conartist_host_name" {
  type    = string
  default = "conartist.app"
}

variable "digitalocean_token" {
  type = string
}

variable "acme_server_url" {
  type    = string
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "gacha_discord_application_id" {
  type = string
}

variable "gacha_discord_token" {
  type      = string
  sensitive = true
}

variable "gacha_sheets_sheet_id" {
  type = string
}

variable "gacha_sheets_client_id" {
  type = string
}

variable "gacha_sheets_client_secret" {
  type      = string
  sensitive = true
}

variable "gacha_sheets_refresh_token" {
  type      = string
  sensitive = true
}

variable "gacha_sheets_redirect_uri" {
  type = string
}

variable "gacha_shopify_shop" {
  type = string
}

variable "gacha_shopify_token" {
  type      = string
  sensitive = true
}

variable "conartist_mailgun_api_key" {
  type      = string
  sensitive = true
}

variable "conartist_mailgun_password" {
  type      = string
  sensitive = true
}

variable "conartist_mailgun_username" {
  type = string
}

variable "jef_discord_application_id" {
  type = string
}

variable "jef_discord_public_key" {
  type = string
}

variable "jef_discord_client_secret" {
  type      = string
  sensitive = true
}

variable "jef_discord_bot_token" {
  type      = string
  sensitive = true
}

variable "jef_shopify_client_id" {
  type = string
}

variable "jef_shopify_client_secret" {
  type      = string
  sensitive = true
}
