BOSH Release Resource
======================

An output only resource that will upload releases to a Bosh target

## Source Configuration

* `target`: *Optional.* The address of the BOSH director which will be used for
  the deployment. If omitted, `target_file` must be specified via `out`
  parameters, as documented below.

When using BOSH with default authentication:
* `username`: *Required.* The username for the BOSH director.
* `password`: *Required.* The password for the BOSH director.

When using BOSH with [UAA authentication](https://bosh.io/docs/director-users-uaa.html#client-login):
* `client_id`: *Required.* The UAA client ID for the BOSH director.
* `client_secret`: *Required.* The UAA client secret for the BOSH director.

* `ca_cert`: *Optional.* CA certificate used to validate SSL connections to Director and UAA.

### Example

``` yaml
resource_types:
- name: bosh-release
  type: docker-image
  source:
    repository: s4xx4s/bosh-release-resource
```

``` yaml
resources:
- name: bosh-release
  type: bosh-release
  source:
    target: https://bosh.example.com:25555
    username: admin
    password: admin
```

``` yaml
jobs:
- name: upload-releases
  plan:
  - put: bosh-release
    params:
      releases:
      - path/to/releases-*.tgz
      - other/path/to/releases-*.tgz
```

## Behaviour

### `out`: Upload releases to a Bosh target

This will upload any given releases to a Bosh target.


#### Parameters

* `releases`: *Required.* An array of globs that should point to where the
  releases used in the deployment can be found.

* `target_file`: *Optional.* Path to a file containing a BOSH director address.
  This allows the target to be determined at runtime, e.g. by acquiring a BOSH
  lite instance using the [Pool
  resource](https://github.com/concourse/pool-resource).

  If both `target_file` and `target` are specified, `target_file` takes
  precedence.
