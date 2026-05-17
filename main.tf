resource "incus_image" "image" {
  source_image  = {
    remote = var.docker_remote
    name ="${var.docker_image}@sha256:${data.docker_registry_image.image.sha256_digest}"
  }
  project = var.incus_project
  alias {
    name = data.docker_registry_image.image.sha256_digest
  }
}
