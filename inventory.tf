module "inventory" {
  source = "github.com/foxfriends/inventory//terraform/modules/docker"

  name       = "inventory"
  config_dir = abspath("${path.module}/inventory/config")
}
