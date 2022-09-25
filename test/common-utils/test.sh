#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json
# that includes the 'common-utils' feature with no options.
#
# Eg:
# {
#    "image": "<..some-base-image...>",
#    "features": {
#      "common-utils": {}
#    }
# }
#
# Thus, the value of all options, will fall back to the default value in the 
# feature's 'devcontainer-feature.json'
# 
# This test can be run with the following command (from the root of this repo)
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
check "unzip" which unzip
check "zsh" zsh --version
check "fish" fish --version
check "exa" exa --version | grep "+git"

# Report result
reportResults
