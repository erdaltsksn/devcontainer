#!/bin/bash

# This test file will be executed against an auto-generated `devcontainer.json`
# that includes the 'go' feature with no options.
#
# Eg:
# {
#     "image": "<ubuntu-based-image>",
#     "features": {
#         "go": {}
#     }
# }
#
# Thus, the value of all options, will fall back to the default value in the
# feature's `devcontainer-feature.json`
#
# This test can be run with the following command (from the root of this repo):
#   devcontainer features test . --features go --base-image ubuntu:22.04

set -e

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "go" go version
check "gopls" gopls version
check "dev" dlv version
check "goplay" command -v goplay
check "gomodifytags" command -v gomodifytags
check "impl" command -v impl
check "gotests" command -v gotests
check "golangci-lint" golangci-lint --version

# Report result
reportResults
