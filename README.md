# A Terraform/Tofu module for updating Incus oci images at apply time

When using the incus provider's `resource.incus_image`, an image is downloaded and named with it's fingerprint by default. If you used a docker tag such as `latest`, the incus image doesn't seem to be updated even if a new image is pushed to the remote.

Using this module ensures that each time you hit `tofu apply`, the docker hub api is checked for a newer fingerprint and the image resource is replaced if necessary.

To use, replace e.g:

```
resource "incus_image" "go-vod" {
  source_image  = {
    remote = "docker"
    name = "radialapps/go-vod"
  }
}

resource "incus_instance" "go-vod" {
    name      = "go-vod"
    image     = resource.incus_image.go-vod.fingerprint
}
```

with:

## Example Usage:

```
module "go-vod_image" {
  source = "github.com/PriceChild/terraform-incus-docker-image-updating?ref=0.0.1"
  docker_image = "radialapps/go-vod"
}

resource "incus_instance" "go-vod" {
    name      = "go-vod"
    image     = module.go-vod_image.fingerprint
}
```