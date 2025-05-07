resource "digitalocean_domain" "conartist" {
  name = "conartist.app"
}

resource "digitalocean_record" "mail_conartist_txt" {
  domain = "conartist.app"
  type   = "TXT"
  name   = "mail"
  value  = "\"v=spf1 include:mailgun.org ~all\""
  ttl    = 3600
}

resource "digitalocean_record" "graph_conartist" {
  domain = "conartist.app"
  type   = "CNAME"
  name   = "graph"
  value  = "@"
  ttl    = 43200
}

resource "digitalocean_record" "smtp_domainkey_conartist" {
  domain = "conartist.app"
  type   = "TXT"
  name   = "smtp._domainkey.mail"
  value  = "\"k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSFQ3C4h1ME8JVGf3YwSxuxrvOmPFf0soYPbqVvHWcGHxirqasu4VQeZ2QDXaZNz/bFCwmBeuN7E9bKGs9WZMNFj1QiTwaGLyj3EhUZrQPZUzfXqCaMS2IkUd8TL+zZXGYuwzzlhy2ieTkmOKQzibDPZgKGzVzqoS+mBzTHgGz4wIDAQAB\""
  ttl    = 3600
}

resource "digitalocean_record" "api_conartist" {
  domain = "conartist.app"
  type   = "CNAME"
  name   = "api"
  value  = "@"
  ttl    = 43200
}

resource "digitalocean_record" "conartist_ns2" {
  domain = "conartist.app"
  type   = "NS"
  name   = "@"
  value  = "ns2.digitalocean.com."
  ttl    = 1800
}

resource "digitalocean_record" "email_conartist" {
  domain = "conartist.app"
  type   = "CNAME"
  name   = "email.conartist.app"
  value  = "mailgun.org."
  ttl    = 43200
}

resource "digitalocean_record" "mail_conartist_mxb" {
  domain   = "conartist.app"
  name     = "mail"
  priority = 10
  ttl      = 14400
  type     = "MX"
  value    = "mxb.mailgun.org."
}

resource "digitalocean_record" "conartist_mxb" {
  domain   = "conartist.app"
  name     = "@"
  priority = 10
  ttl      = 14400
  type     = "MX"
  value    = "mxb.mailgun.org."
}

resource "digitalocean_record" "email_mail_conartist" {
  domain = "conartist.app"
  type   = "CNAME"
  name   = "email.mail"
  value  = "mailgun.org."
  ttl    = 43200
}

resource "digitalocean_record" "conartist_ns3" {
  domain = "conartist.app"
  type   = "NS"
  name   = "@"
  value  = "ns3.digitalocean.com."
  ttl    = 1800
}

resource "digitalocean_record" "conartist_mxa" {
  domain   = "conartist.app"
  type     = "MX"
  name     = "@"
  value    = "mxa.mailgun.org."
  ttl      = 14400
  priority = 10
}

resource "digitalocean_record" "conartist_ns1" {
  domain = "conartist.app"
  type   = "NS"
  name   = "@"
  value  = "ns1.digitalocean.com."
  ttl    = 1800
}

resource "digitalocean_record" "conartist_txt" {
  domain = "conartist.app"
  type   = "TXT"
  name   = "@"
  value  = "\"v=spf1 include:mailgun.org ~all\""
  ttl    = 3600
}

resource "digitalocean_record" "k1_domainkey_conartist" {
  domain = "conartist.app"
  type   = "TXT"
  name   = "k1._domainkey"
  value  = "\"k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDfLVzy81cC+hNFNa7YxUafE+uDvT5taqvQ0KU9ew/ZZI12LZ3T79jvmAmB0sYaaHiefBhCQWjDrhY8PznYvx1Qfo09fEt9VrhMYwQT75KJGBL1aKnKmb2mSMiWoQmBaG6VVg/GncOk4TzV9ZQMKZ4PiDSZBDlmzCcytMKXTFow6wIDAQAB\""
  ttl    = 3600
}

resource "digitalocean_record" "mail_conartist_mxa" {
  domain   = "conartist.app"
  type     = "MX"
  name     = "mail"
  value    = "mxa.mailgun.org."
  ttl      = 14400
  priority = 10
}

resource "digitalocean_record" "conartist" {
  domain = "conartist.app"
  type   = "A"
  name   = "@"
  value  = "159.203.22.112"
  ttl    = 3600
}
