#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json
# that includes the 'gp' feature with no options.
#
# Eg:
# {
#    "image": "<..some-base-image...>",
#    "features": {
#      "gp": {}
#    }
# }
#
# Thus, the value of all options, will fall back to the default value in the 
# feature's 'devcontainer-feature.json'
# 
# This test can be run with the following command (from the root of this repo)
#   devcontainer features test . --features go --base-image ubuntu:22.04

set -e

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "go" go version
check "gopls" gopls version
check "dev" dlv version
check "goplay" which goplay
check "gomodifytags" which gomodifytags
check "impl" which impl
check "gotests" which gotests
check "golangci-lint" golangci-lint --version

# Report result
reportResults
