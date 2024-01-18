#!/bin/bash

# Updating the package list and versions
sudo apt update
sudo apt install -y software-properties-common apt-transport-https wget

# Installing Python 3
sudo apt install -y python3

# Installing Go
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz # Download Go
sudo tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz # Extract Go to /usr/local
export PATH=$PATH:/usr/local/go/bin # Update PATH to include Go binaries
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc # Persist PATH update
rm go1.21.6.linux-amd64.tar.gz # Remove Go package

# Installing Java JDK 21
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb # Download Java JDK 21
sudo dpkg -i jdk-21_linux-x64_bin.deb # Install Java JDK 21
rm jdk-21_linux-x64_bin.deb # Remove Java JDK 21 package

# Installing Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - # Add Node.js PPA
sudo apt install -y nodejs # Install Node.js

# Installing Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # Install Rust using rustup
export PATH=$PATH:$HOME/.cargo/bin # Update PATH to include Rust binaries
echo 'export PATH=$PATH:$HOME/.cargo/bin' >> ~/.zshrc # Persist PATH update

# Installing .NET (C#)
# https://github.com/dotnet/core/issues/7699
# https://github.com/dotnet/sdk/issues/27129#issuecomment-1214358108
sudo apt install dotnet-sdk-8.0
