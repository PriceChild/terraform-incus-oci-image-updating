output "fingerprint" {
  value = resource.incus_image.image.fingerprint
}
output "docker_image" {
  value = "${var.docker_image}@sha256:${data.docker_registry_image.image.sha256_digest}"
}
