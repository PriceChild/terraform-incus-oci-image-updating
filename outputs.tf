output "fingerprint" {
  value = resource.incus_image.image.fingerprint
}
output "docker_image" {
  value = data.external.image.result.docker_image
}
