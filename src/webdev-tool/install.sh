#!/bin/sh
set -e

# Define the target directory
TARGET_DIR="$HOME/webdev"

# Define the version
WEBDEV_VERSION=${VERSION:-latest}

echo "Installing WebDev-Tool to: $TARGET_DIR"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Switch to target dir
cd $TARGET_DIR

# Downloading the desired version of the tool
echo "Downloading version $WEBDEV_VERSION"

curl -s https://api.github.com/repos/Derroylo/webdev-tool/releases/$WEBDEV_VERSION | grep "browser_download_url.*zip" | cut -d : -f 2,3 | tr -d \" | wget -qi -

# Unpack the webdev-tool.zip into the target directory
unzip -o webdev-tool.zip -d "$TARGET_DIR"

echo "webdev-tool.zip has been unpacked into $TARGET_DIR"

# Remove the zip file
rm webdev-tool.zip

# Mark as executable
chmod +x $HOME/webdev/webdev.sh

# Set owner for the webdev folder
chown -R $_REMOTE_USER:$_REMOTE_USER $TARGET_DIR

# Add symlink for the tool
ln -s $HOME/webdev/webdev.sh /usr/local/bin/webdev

echo "All done"