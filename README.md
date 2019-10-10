# Make Container Action

This action simply executes 'make' with the provided `args` (if any) using
the latest Fedora container image with container-tools pre-installed:

* Buildah
* Podman
* Shopeo

## Env

### ARTIFACTS_DIRPATH

**Optional**: Path to create before executing make, and persist to the next action (as an env. var.)

## Inputs

### `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Outputs

### `time`

The time we greeted you.

## Example usage

```yaml
uses: actions/hello-world-docker-action@master
with:
  who-to-greet: 'Mona the Octocat'
```
