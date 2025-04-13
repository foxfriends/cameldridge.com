resource "acme_registration" "cameldridge" {
  email_address = "cameldridge@gmail.com"
}

resource "acme_certificate" "cookiealyst" {
  account_key_pem           = acme_registration.cameldridge.account_key_pem
  common_name               = "*.cookiealyst.com"
  subject_alternative_names = ["cookiealyst.com"]

  dns_challenge {
    provider = "digitalocean"
    config = {
      DO_AUTH_TOKEN = var.digitalocean_token
    }
  }
}

resource "acme_certificate" "cameldridge" {
  account_key_pem           = acme_registration.cameldridge.account_key_pem
  common_name               = "*.cameldridge.com"
  subject_alternative_names = ["cameldridge.com"]

  dns_challenge {
    provider = "digitalocean"
    config = {
      DO_AUTH_TOKEN = var.digitalocean_token
    }
  }
}

resource "acme_certificate" "conartist" {
  account_key_pem           = acme_registration.cameldridge.account_key_pem
  common_name               = "*.conartist.app"
  subject_alternative_names = ["conartist.app"]

  dns_challenge {
    provider = "digitalocean"
    config = {
      DO_AUTH_TOKEN = var.digitalocean_token
    }
  }
}

resource "local_file" "cookiealyst_fullchain" {
  content  = "${acme_certificate.cookiealyst.certificate_pem}${acme_certificate.cookiealyst.issuer_pem}"
  filename = abspath("${path.module}/nginx/ssl/cookiealyst.com/fullchain.pem")
}

resource "local_sensitive_file" "cookiealyst_privkey" {
  content  = acme_certificate.cookiealyst.private_key_pem
  filename = abspath("${path.module}/nginx/ssl/cookiealyst.com/privkey.pem")
}

resource "local_file" "cameldridge_fullchain" {
  content  = "${acme_certificate.cameldridge.certificate_pem}${acme_certificate.cameldridge.issuer_pem}"
  filename = abspath("${path.module}/nginx/ssl/cameldridge.com/fullchain.pem")
}

resource "local_sensitive_file" "cameldridge_privkey" {
  content  = acme_certificate.cameldridge.private_key_pem
  filename = abspath("${path.module}/nginx/ssl/cameldridge.com/privkey.pem")
}

resource "local_file" "conartist_fullchain" {
  content  = "${acme_certificate.conartist.certificate_pem}${acme_certificate.conartist.issuer_pem}"
  filename = abspath("${path.module}/nginx/ssl/conartist.app/fullchain.pem")
}

resource "local_sensitive_file" "conartist_privkey" {
  content  = acme_certificate.conartist.private_key_pem
  filename = abspath("${path.module}/nginx/ssl/conartist.app/privkey.pem")
}
