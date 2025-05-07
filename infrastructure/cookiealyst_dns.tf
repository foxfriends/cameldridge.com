resource "digitalocean_domain" "cookiealyst" {
  name = "cookiealyst.com"
}

resource "digitalocean_record" "cookiealyst_ns1" {
  domain = "cookiealyst.com"
  type   = "NS"
  name   = "@"
  value  = "ns1.digitalocean.com."
}

resource "digitalocean_record" "cookiealyst_ns2" {
  domain = "cookiealyst.com"
  name   = "@"
  type   = "NS"
  value  = "ns2.digitalocean.com."
}

resource "digitalocean_record" "cookiealyst_ns3" {
  domain = "cookiealyst.com"
  type   = "NS"
  name   = "@"
  value  = "ns3.digitalocean.com."
}

resource "digitalocean_record" "cookiealyst" {
  domain = "cookiealyst.com"
  type   = "A"
  name   = "@"
  value  = "159.203.22.112"
  ttl    = 3600
}

resource "digitalocean_record" "www_cookiealyst" {
  domain = "cookiealyst.com"
  type   = "CNAME"
  name   = "www"
  value  = "@"
  ttl    = 43200
}
