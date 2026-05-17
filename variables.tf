variable "docker_image" {
  type      = string
  description = "The docker image to get information for"
}

variable "docker_remote" {
  type      = string
  default   = "docker.io"
  description = "Incus remote OCI registry name"
}

variable "incus_project" {
  type      = string
  default   = "default"
  description = "Incus project name"
}
