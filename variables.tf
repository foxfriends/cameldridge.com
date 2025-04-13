variable "digitalocean_token" {
  type = string
}

variable "acme_server_url" {
  type    = string
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}
