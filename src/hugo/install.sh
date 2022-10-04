#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Ensure apt is in non-interactive to avoid prompts
# https://bugs.debian.org/929417
export DEBIAN_FRONTEND=noninteractive

# Fetch the latest version of the package list from Ubuntu's repositories.
apt update -y

# Install script-related dependencies.
apt install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    tar \

# Clean up.
apt autoremove -y && \
rm -rf /var/lib/apt/lists/*

# Fetch latest version of Hugo if needed.
if [ "${VERSION}" = "latest" ]; then
    latest=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}')
    export VERSION="${latest}"
fi

# Build hugo package file name.
HUGO_FILE="${VARIANT}_${VERSION}_Linux-64bit.tar.gz"

# Download binaries from the release page.
wget "https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${HUGO_FILE}"

# Prepare folders.
mkdir -p /usr/local/bin
# Unpack downloaded content.
tar -zxf "${HUGO_FILE}" -C /usr/local/bin

# Clean the leftovers.
rm "${HUGO_FILE}"
