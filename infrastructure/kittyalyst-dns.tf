resource "digitalocean_domain" "kittyalyst" {
  name = "kittyalyst.com"
}

resource "digitalocean_record" "kittyalyst" {
  domain = "kittyalyst.com"
  type   = "A"
  name   = "@"
  value  = "23.227.38.65"
  ttl    = 3600
}

resource "digitalocean_record" "card_kittyalyst" {
  domain = "kittyalyst.com"
  type   = "A"
  name   = "card"
  value  = "159.203.22.112"
  ttl    = 3600
}

resource "digitalocean_record" "www_kittyalyst" {
  domain = "kittyalyst.com"
  type   = "CNAME"
  name   = "www"
  value  = "shops.myshopify.com"
  ttl    = 43200
}

resource "digitalocean_record" "kittyalyst_ns1" {
  domain = "kittyalyst.com"
  type   = "NS"
  name   = "@"
  value  = "ns1.digitalocean.com."
  ttl    = 1800
}

resource "digitalocean_record" "kittyalyst_ns2" {
  domain = "kittyalyst.com"
  type   = "NS"
  name   = "@"
  value  = "ns2.digitalocean.com."
  ttl    = 1800
}

resource "digitalocean_record" "kittyalyst_ns3" {
  domain = "kittyalyst.com"
  type   = "NS"
  name   = "@"
  value  = "ns3.digitalocean.com."
  ttl    = 1800
}
