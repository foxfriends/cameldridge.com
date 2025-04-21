module "cookiealyst" {
  source = "github.com/foxfriends/cookiealyst//terraform/modules/docker"

  name       = "cookiealyst"
  data_dir   = abspath("${path.module}/cookiealyst/load")
  images_dir = abspath("${path.module}/cookiealyst/images")
}
