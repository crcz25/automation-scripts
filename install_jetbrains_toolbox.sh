#!/bin/bash

# Variables
DOWNLOAD_URL="https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.4.2.32922.tar.gz"  # Replace this with the latest version URL if necessary
INSTALL_DIR="/opt"
TMP_DIR="/tmp/jetbrains-toolbox"

# Download JetBrains Toolbox
echo "Downloading JetBrains Toolbox..."
wget -O $TMP_DIR/toolbox.tar.gz $DOWNLOAD_URL

# Extract the tarball
echo "Extracting JetBrains Toolbox..."
mkdir -p $TMP_DIR
tar -xvzf $TMP_DIR/toolbox.tar.gz -C $TMP_DIR

# Install to /opt directory
echo "Installing JetBrains Toolbox to $INSTALL_DIR..."
sudo mkdir -p $INSTALL_DIR
sudo mv $TMP_DIR/jetbrains-toolbox-*/* $INSTALL_DIR

# Cleanup
rm -rf $TMP_DIR

# Notify user of successful installation
echo "JetBrains Toolbox installation complete!"
echo "You can now launch JetBrains Toolbox from the application menu or by running '$INSTALL_DIR/jetbrains-toolbox' in the terminal."
