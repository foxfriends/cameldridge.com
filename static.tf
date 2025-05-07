data "docker_registry_image" "cameldridge" {
  name = "ghcr.io/foxfriends/cameldridge:main"
}

resource "terraform_data" "cameldridge_sha" {
  input = data.docker_registry_image.cameldridge.sha256_digest
}

resource "docker_image" "cameldridge" {
  name          = "ghcr.io/foxfriends/cameldridge:main"
  pull_triggers = [data.docker_registry_image.cameldridge.sha256_digest]
}

resource "docker_container" "cameldridge" {
  image = docker_image.cameldridge.image_id
  name  = "cameldridge"

  must_run = false

  volumes {
    container_path = "/app/dist"
    volume_name    = docker_volume.cameldridge.name
  }

  network_mode = "none"
}

resource "docker_volume" "cameldridge" {
  name = "cameldridge-${substr(data.docker_registry_image.cameldridge.sha256_digest, 7, 8)}"
}
