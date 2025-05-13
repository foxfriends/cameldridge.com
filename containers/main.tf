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
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"

  registry_auth {
    address     = "ghcr.io"
    config_file = pathexpand("~/.docker/config.json")
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

provider "acme" {
  server_url = var.acme_server_url
}

data "docker_network" "bridge" {
  name = "bridge"
}
