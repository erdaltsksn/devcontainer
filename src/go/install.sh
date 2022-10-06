#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Ensure apt is in non-interactive to avoid prompts
# https://bugs.debian.org/929417
export DEBIAN_FRONTEND=noninteractive

# Fetch the latest version of the package list from Ubuntu's repositories.
apt update -y

# Install cgo-related dependencies.
apt install -y --no-install-recommends \
    g++ \
    gcc \
    libc6-dev \
    make \
    pkg-config \

# Install script-related dependencies.
apt install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    gnupg2 \
    jq \

# Clean up.
apt autoremove -y && \
rm -rf /var/lib/apt/lists/*

if [ "${VERSION}" = "latest" ]; then
    GO_VERSION=$(wget -qO- 'https://go.dev/dl/?mode=json' | jq -r 'map(select(.version))'[0].version)
    export VERSION="${GO_VERSION}"
else
    GO_VERSION=$(wget -qO- 'https://go.dev/dl/?mode=json' | jq -r 'map(select(.version | startswith('\"go$VERSION\"')))'[0].version)
    export VERSION="${GO_VERSION}"
fi

# Build go package file name.
GO_FILE="${VERSION}.linux-amd64.tar.gz"

# Download binaries from the release page.
wget "https://go.dev/dl/${GO_FILE}"

# Remove any previous Go installation by deleting the /usr/local/go folder.
# Create a fresh Go tree in /usr/local/go by extracting the archive.
rm -rf /usr/local/go && tar -xzf "${GO_FILE}" -C /usr/local

# Add /usr/local/go/bin to the PATH environment variable.
export PATH=$PATH:/usr/local/go/bin

# Clean the leftovers.
rm "${GO_FILE}"

# Install Go tools.
# https://github.com/golang/vscode-go/blob/master/docs/tools.md
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/haya14busa/goplay/cmd/goplay@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
