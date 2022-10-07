#!/bin/bash

# This test file will be executed against `scenarios.json` that includes
# the 'hugo' feature with the following options.
#
# {
#     "image": "ubuntu:22.04",
#     "features": {
#         "hugo": {
#             "variant": "hugo",
#             "version": "0.101.0"
#         }
#     }
# }
#
# This test can be run with the following command (from the root of this repo):
#   devcontainer features test . --features hugo --base-image ubuntu:22.04

set -e

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "hugo" hugo version
# Scenarios-specific tests
check "hugo not extended" hugo version | (! grep "+extended")
check "version" hugo version | grep "v0.101.0"

# Report result
reportResults
