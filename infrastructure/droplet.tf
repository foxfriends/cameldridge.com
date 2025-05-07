resource "digitalocean_droplet" "cloud-cat" {
  name  = "cloud-cat"
  image = "ubuntu-24-04-x64"

  region = "tor1"
  size   = "s-1vcpu-2gb"

  backups    = false
  monitoring = true
}
