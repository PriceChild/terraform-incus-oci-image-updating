resource "incus_image" "image" {
  source_image  = {
    remote = "docker"
    name = data.external.image.query.docker_image
  }
  project = var.incus_project
  aliases = [data.external.image.result.fingerprint]
}
