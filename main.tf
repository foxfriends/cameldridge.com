terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "2.31.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.50.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "digitalocean" {
  token = var.digitalocean_token
}

provider "acme" {
  server_url = var.acme_server_url
}
