data "external" "image" {
  program = ["bash", "${path.module}/docker-fingerprint.sh"]

  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    docker_image = var.docker_image
  }
}
