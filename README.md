# A Terraform/Tofu module for updating Incus oci images at apply time

When using the incus provider's `resource.incus_image`, an image is downloaded and named with it's fingerprint by default. If you used a docker tag such as `latest`, the incus image doesn't seem to be updated even if a new image is pushed to the remote.

Using this module ensures that each time you hit `tofu apply`, the provided docker registry (defaulted to Docker Hub) is checked for a newer fingerprint and the image resource is replaced if necessary.

> [!WARNING]
> [`skopeo`](https://github.com/containers/skopeo/blob/main/install.md) needs to be installed to be able to gather image information.

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
  source = "github.com/PriceChild/terraform-incus-docker-image-updating?ref=0.0.2"
  docker_image = "radialapps/go-vod"
}

resource "incus_instance" "go-vod" {
    name      = "go-vod"
    image     = module.go-vod_image.fingerprint
}
```

---

## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_docker"></a> [docker](#provider\_docker) | n/a |
| <a name="provider_incus"></a> [incus](#provider\_incus) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [incus_image.image](https://registry.terraform.io/providers/lxc/incus/latest/docs/resources/image) | resource |
| [docker_registry_image.image](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/data-sources/registry_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_docker_image"></a> [docker\_image](#input\_docker\_image) | The docker image to get information for | `string` | n/a | yes |
| <a name="input_docker_remote"></a> [docker\_remote](#input\_docker\_remote) | Incus remote OCI registry name | `string` | `"docker.io"` | no |
| <a name="input_incus_project"></a> [incus\_project](#input\_incus\_project) | Incus project name | `string` | `"default"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_docker_image"></a> [docker\_image](#output\_docker\_image) | Docker image reference with digest |
| <a name="output_fingerprint"></a> [fingerprint](#output\_fingerprint) | SHA256 digest of the provided docker image |
