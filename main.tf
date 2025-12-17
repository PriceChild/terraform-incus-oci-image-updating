resource "incus_image" "image" {
  source_image  = {
    remote = "docker"
    name = data.external.image.result.docker_image
  }
  project = var.incus_project
  alias {
    name = data.external.image.result.fingerprint
  }
}
