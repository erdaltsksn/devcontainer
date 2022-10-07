#!/bin/bash

# This test file will be executed against an auto-generated `devcontainer.json`
# that includes the 'hugo' feature with no options.
#
# Eg:
# {
#     "image": "<ubuntu-based-image>",
#     "features": {
#         "hugo": {}
#     }
# }
#
# Thus, the value of all options, will fall back to the default value in the
# feature's `devcontainer-feature.json`
#
# This test can be run with the following command (from the root of this repo):
#   devcontainer features test . --features hugo --base-image ubuntu:22.04

set -e

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "hugo" hugo version | grep "+extended"

# Report result
reportResults
