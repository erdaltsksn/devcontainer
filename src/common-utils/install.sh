#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Ensure apt is in non-interactive to avoid prompts
# https://bugs.debian.org/929417
export DEBIAN_FRONTEND=noninteractive

# Fetch the latest version of the package list from Ubuntu's repositories.
apt update -y

# Get to latest versions of all packages.
apt upgrade -y --no-install-recommends

# Install must-have applications.
apt install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    tzdata \
    software-properties-common \
# Install common applications.
apt install -y --no-install-recommends \
    openssh-client \
    gnupg2 \
# Install useful applications.
apt install -y --no-install-recommends \
    git \
    make \
    unzip \

# Optionally install 'zsh'.
if [ "${INSTALL_ZSH}" = "true" ]; then
    apt install -y --no-install-recommends zsh
fi

# Optionally install 'fish'.
if [ "${INSTALL_FISH}" = "true" ]; then
    apt install -y --no-install-recommends fish
fi

# Optionally install 'exa'.
if [ "${INSTALL_EXA}" = "true" ]; then
    # apt install -y --no-install-recommends exa
    # https://github.com/ogham/exa/issues/761#issuecomment-737453955
    #
    # ----- Fix for git supported exa version. ---------------------------------
    EXA_VERSION=$(curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}')
    wget "https://github.com/ogham/exa/releases/download/v${EXA_VERSION}/exa-linux-x86_64-v${EXA_VERSION}.zip"
    unzip -q "exa-linux-x86_64-v${EXA_VERSION}.zip" bin/exa -d /usr/local
    rm "exa-linux-x86_64-v${EXA_VERSION}.zip"
    # ----- Fix for git supported exa version. ---------------------------------
fi

# Clean up.
apt autoremove -y && \
rm -rf /var/lib/apt/lists/*
