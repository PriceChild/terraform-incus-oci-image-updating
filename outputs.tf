output "fingerprint" {
  value = resource.incus_image.image.fingerprint
  description = "SHA256 digest of the provided docker image"
}
output "docker_image" {
  value = "${var.docker_image}@sha256:${data.docker_registry_image.image.sha256_digest}"
  description = "Docker image reference with digest"
}
