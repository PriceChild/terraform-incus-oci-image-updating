resource "incus_image" "image" {
  source_image  = {
    remote = "docker"
    name = data.external.image.query.docker_image
  }
  project = var.incus_project
  alias {
    name = data.external.image.result.fingerprint
  }

  lifecycle {
    create_before_destroy = true
  }
}
