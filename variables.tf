variable "digitalocean_token" {
  type = string
}

variable "acme_server_url" {
  type    = string
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "discord_token" {
  type      = string
  sensitive = true
}

variable "sheets_client_secret" {
  type      = string
  sensitive = true
}

variable "sheets_access_token" {
  type      = string
  sensitive = true
}

variable "sheets_refresh_token" {
  type      = string
  sensitive = true
}

variable "shopify_token" {
  type      = string
  sensitive = true
}

