terraform {
  required_providers {
    incus = {
      source = "lxc/incus"
    }
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
}
