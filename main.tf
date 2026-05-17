resource "incus_image" "image" {
  source_image  = {
    remote = var.docker_remote
    name ="${var.docker_image}@${data.docker_registry_image.image.sha256_digest}"
  }
  project = var.incus_project
  alias {
    name = trimprefix(data.docker_registry_image.image.sha256_digest, "sha256:")
  }
}
