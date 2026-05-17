variable "docker_image" {
  type      = string
}

variable "docker_remote" {
  type      = string
  default   = "docker"
}

variable "incus_project" {
  type      = string
  default   = "default"
}
