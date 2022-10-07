#!/bin/bash

# This test file will be executed against `scenarios.json` that includes
# the 'go' feature with the following options.
#
# {
#     "image": "ubuntu:22.04",
#     "features": {
#         "go": {
#             "version": "1.18"
#         }
#     },
#     "postCreateCommand": "go install github.com/erdaltsksn/random/cmd/random@latest"
# }
#
# This test can be run with the following command (from the root of this repo)
#   devcontainer features test . --features go --base-image ubuntu:22.04

set -e

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "gopls" gopls version
check "dev" dlv version
check "goplay" command -v goplay
check "gomodifytags" command -v gomodifytags
check "impl" command -v impl
check "gotests" command -v gotests
check "golangci-lint" golangci-lint --version
# Scenarios-specific tests
check "go version 1.18" go version | grep "go1.18"
# The command `random` is installed by `postCreateCommand`.
check "random" random version

# Report result
reportResults
