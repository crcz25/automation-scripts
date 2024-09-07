#!/bin/bash

# Get the params from the command line
# <non_root_user>: Flag to create the group docker and add the user to it

# Check if --non-root parameter is provided
NON_ROOT=false
if [ $# -eq 1 ]; then
    if [ $1 == "--non-root" ]; then
        NON_ROOT=true
    else
        echo "Invalid argument. Usage: ./install_docker_fedora.sh [--non-root]"
        exit 1
    fi
fi

# Ensure the script is run as root or using sudo
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo privileges."
   exit 1
fi

# Update the system
echo -e "\nUpdating system packages..."
dnf -y update

# Install required packages
echo -e "\nInstalling required packages..."
dnf -y install dnf-plugins-core

# Add the Docker repository
echo -e "\nAdding Docker repository..."
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker Engine
echo -e "\nInstalling Docker Engine..."
dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker service
echo -e "\nStarting and enabling Docker services..."
systemctl start docker
systemctl enable docker.service
systemctl enable containerd.service


# Optional: Add current user to the docker group if --non-root is passed
if [ $NON_ROOT == true ]; then
    # Check if the group docker exists
    if [ $(getent group docker) ]; then
        echo -e "\nGroup docker already exists."
    else
        echo -e "\nCreating group docker..."
        groupadd docker
    fi
    # Add the current user to the docker group
    INVOKING_USER=${SUDO_USER:-$USER}
    if [ $(id -nG "$INVOKING_USER" | grep -c docker) -ne 0 ]; then
        echo -e "\nUser $INVOKING_USER is already in the docker group."
    else
        echo -e "\nAdding user $INVOKING_USER to the docker group for non-root Docker execution..."
        usermod -aG docker $INVOKING_USER
        echo -e "\nUser $INVOKING_USER added to the docker group. Please log out and log back in to apply the changes."
    fi
fi

# Test Docker installation
echo -e "\nVerifying Docker installation..."
docker --version && docker run hello-world && echo "Docker installation successful!" || echo "Docker installation failed."
