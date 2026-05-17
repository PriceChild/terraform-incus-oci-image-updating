resource "incus_image" "image" {
  source_image  = {
    remote = var.docker_remote
    name = var.docker_image
  }
  project = var.incus_project
  alias {
    name = data.docker_registry_image.image.sha256_digest
  }
}
