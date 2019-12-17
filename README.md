# Make Container Action

This action simply executes 'make' with the provided `args` (if any) using
the latest Fedora container image with container-tools pre-installed:

* Buildah
* Podman
* Shopeo

## Inputs

*see `action.yml`*

## Example usage

```yaml
uses: cevich/makecontaineraction@v1.4
with:
    args: make_target
    artifacts_dirpath: ./path/to/stuff
```
