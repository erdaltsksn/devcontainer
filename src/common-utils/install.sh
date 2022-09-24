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

# Clean up.
apt autoremove -y && \
rm -rf /var/lib/apt/lists/*
