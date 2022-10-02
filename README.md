# DevContainer Features

[![Test](https://github.com/erdaltsksn/devcontainer/actions/workflows/test.yml/badge.svg)](https://github.com/erdaltsksn/devcontainer/actions/workflows/test.yml)
[![Security Scan](https://github.com/erdaltsksn/devcontainer/actions/workflows/security.yml/badge.svg)](https://github.com/erdaltsksn/devcontainer/actions/workflows/security.yml)

This repository contains a collection of simple and reusable `devcontainer`
features. Features are designed to install atop a wide-range of base container
images (**This repo uses `ubuntu` for the base image**).

## Features

- Simple
- Reusable
- Follow the [**proposed**  dev container feature distribution specification](https://containers.dev/implementors/features-distribution/)

## Requirements

- A [tool supporting the dev container specification](https://containers.dev/supporting)

## Getting Started

To reference a feature from this repository, add the desired features to a
`devcontainer.json`. Each feature has a `README.md` that shows how to reference
the feature and which options are available for that feature.

```jsonc
"image": "ubuntu:22.04", // Any generic, debian-based image.
"features": {
    "ghcr.io/erdaltsksn/devcontainer/common-utils:1": {}
}
```

## Usage

### Repo and Feature Structure

Similar to the [`devcontainers/features`](https://github.com/devcontainers/features)
repo, this repository has a `src` folder. Each feature has its own sub-folder,
containing at least a `devcontainer-feature.json` and an entrypoint script
`install.sh`.

```html
├── src
│   ├── common-utils
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
|   ├── ...
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
...
```

An [implementing tool](https://containers.dev/supporting#tools) will composite
[the documented dev container properties](https://containers.dev/implementors/features/#devcontainer-feature-json-properties)
from the feature's `devcontainer-feature.json` file, and execute in the
`install.sh` entrypoint script in the container during build time. Implementing
tools are also free to process attributes under the `customizations` property as
desired.

### Options

All available options for a feature should be declared in the
`devcontainer-feature.json`. The syntax for the `options` property can be found
in the [devcontainer feature json properties reference](https://containers.dev/implementors/features/#devcontainer-feature-json-properties).

Options are exported as feature-scoped environment variables. The option name is
capitalized and sanitized according to [option resolution](https://containers.dev/implementors/features/#option-resolution).

### Versioning

Features are individually versioned by the `version` attribute in a feature's
`devcontainer-feature.json`. Features are versioned according to the semver
specification. More details can be found in [the dev container feature specification](https://containers.dev/implementors/features/#versioning).

## Contributing

If you want to contribute to this project and make it better, your help is very
welcome.

For more information, see [Contributing Guide](https://github.com/erdaltsksn/.github/blob/main/CONTRIBUTING.md).

## Security Policy

If you discover a security vulnerability within this project, please follow our
[Security Policy](https://github.com/erdaltsksn/.github/blob/main/SECURITY.md).

## Code of Conduct

This project adheres to the Contributor Covenant [Code of Conduct](https://github.com/erdaltsksn/.github/blob/main/CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code.

## Disclaimer

In no event shall we be liable to you or any third parties for any special,
punitive, incidental, indirect or consequential damages of any kind, or any
damages whatsoever, including, without limitation, those resulting from loss of
use, data or profits, and on any theory of liability, arising out of or in
connection with the use of this software.
