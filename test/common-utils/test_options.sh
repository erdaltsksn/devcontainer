#!/bin/bash

# This test file will be executed against `scenarios.json` that includes
# the 'common-utils' feature with the following options.
#
# {
#     "image": "ubuntu:22.04",
#     "features": {
#         "common-utils": {
#             "install_zsh": false,
#             "install_fish": false,
#             "install_exa": false
#         }
#     }
# }
#
# This test can be run with the following command (from the root of this repo):
#   devcontainer features test . --features common-utils --base-image ubuntu:22.04

set -e

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "curl" curl --version
check "wget" wget --version
check "git" git --version
check "make" make --version
check "unzip" command -v unzip
# Scenarios-specific tests
check "zsh is not installed" [ ! "$(command -v zsh)" ]
check "fish is not installed" [ ! "$(command -v fish)" ]
check "exa is not installed" [ ! "$(command -v exa)" ]

# Report result
reportResults
