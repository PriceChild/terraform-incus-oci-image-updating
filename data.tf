data "docker_registry_image" "image" {
  name = "${var.docker_remote}/${var.docker_image}"
}
