resource "digitalocean_domain" "cameldridge" {
  name = "cameldridge.com"
}

resource "digitalocean_record" "www_cameldridge" {
  domain = "cameldridge.com"
  type   = "CNAME"
  name   = "www"
  value  = "@"
  ttl    = 43200
}

resource "digitalocean_record" "cameldridge" {
  domain = "cameldridge.com"
  type   = "A"
  name   = "@"
  value  = "159.203.22.112"
  ttl    = 3600
}

resource "digitalocean_record" "mahjong_cameldridge" {
  domain = "cameldridge.com"
  type   = "A"
  name   = "mahjong"
  value  = "159.203.22.112"
  ttl    = 3600
}

resource "digitalocean_record" "machi_cameldridge" {
  domain = "cameldridge.com"
  type   = "A"
  name   = "machi"
  value  = "159.203.22.112"
  ttl    = 3600
}

resource "digitalocean_record" "inventory_cameldridge" {
  domain = "cameldridge.com"
  type   = "A"
  name   = "inventory"
  value  = "159.203.22.112"
  ttl    = 3600
}

resource "digitalocean_record" "jef_cameldridge" {
  domain = "cameldridge.com"
  type   = "A"
  name   = "jef"
  value  = "159.203.22.112"
  ttl    = 3600
}

resource "digitalocean_record" "catan_cameldridge" {
  domain = "cameldridge.com"
  type   = "A"
  name   = "catan"
  value  = "159.203.22.112"
  ttl    = 3600
}

resource "digitalocean_record" "tokaido_cameldridge" {
  domain = "cameldridge.com"
  type   = "A"
  name   = "tokaido"
  value  = "159.203.22.112"
  ttl    = 3600
}

resource "digitalocean_record" "test_shop_cameldridge" {
  domain = "cameldridge.com"
  type   = "CNAME"
  name   = "test-shop"
  value  = "shops.myshopify.com."
  ttl    = 43200
}

resource "digitalocean_record" "cameldridge_ns1" {
  domain = "cameldridge.com"
  type   = "NS"
  name   = "@"
  value  = "ns1.digitalocean.com."
  ttl    = 1800
}

resource "digitalocean_record" "cameldridge_ns2" {
  domain = "cameldridge.com"
  type   = "NS"
  name   = "@"
  value  = "ns2.digitalocean.com."
  ttl    = 1800
}

resource "digitalocean_record" "cameldridge_ns3" {
  domain = "cameldridge.com"
  type   = "NS"
  name   = "@"
  value  = "ns3.digitalocean.com."
  ttl    = 1800
}
