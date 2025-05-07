resource "digitalocean_app" "notes" {
  spec {
    features = ["buildpack-stack=ubuntu-22"]
    name     = "notes"
    region   = "tor"
    alert {
      rule = "DEPLOYMENT_FAILED"
    }
    alert {
      rule = "DOMAIN_FAILED"
    }
    ingress {
      rule {
        component {
          name = "notes"
        }
        match {
          path {
            prefix = "/"
          }
        }
      }
    }
    static_site {
      catchall_document = "index.html"
      dockerfile_path   = "Dockerfile"
      name              = "notes"
      output_dir        = "/app/dist"
      source_dir        = "/"
      github {
        branch         = "main"
        deploy_on_push = true
        repo           = "foxfriends/notes"
      }
    }
  }
}

resource "digitalocean_app" "blog" {
  spec {
    features = ["buildpack-stack=ubuntu-22"]
    name     = "blog"
    region   = "tor"

    alert { rule = "DEPLOYMENT_FAILED" }
    alert { rule = "DOMAIN_FAILED" }

    ingress {
      rule {
        component {
          name = "blog"
        }
        match {
          path {
            prefix = "/"
          }
        }
      }
    }
    static_site {
      dockerfile_path = "Dockerfile"
      name            = "blog"
      output_dir      = "/app/dist"
      source_dir      = "/"
      github {
        branch         = "main"
        deploy_on_push = true
        repo           = "foxfriends/blog"
      }
    }
  }
}
