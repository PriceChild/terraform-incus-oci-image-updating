output "fingerprint" {
  value = data.external.image.result.fingerprint
  depends_on = [
    # Don't use the image until it's been created:
    resource.incus_image.image
  ]
}
