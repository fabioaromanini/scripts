#!/bin/bash

DOCKER_VERSION="docker-ce_17.12.1~ce-0~ubuntu_amd64"
DOCKER_MNT="/mnt/docker"

DOWNLOADS_DIR="$HOME/Downloads/workspace/"
FILE_NAME="$DOCKER_VERSION.deb"
DOCKER_PATH="$DOWNLOADS_DIR$FILE_NAME"

if [ ! -d $DOCKER_MNT ]; then
	echo "Installation requires $DOCKER_MNT"
	exit 1
else
	echo "disk mounted"
fi


if [ ! -f $DOCKER_PATH ]; then
    echo "Docker pkg not found!"
	wget -P $DOWNLOADS_DIR https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/$FILE_NAME
else
    echo "Docker pkg found!"
fi

# Checks if docker is installed, and use it's output to decide if should install or not
DOCKER_INSTALLED=$(sudo dpkg-query -l | grep "docker" | wc -l)

if [ $DOCKER_INSTALLED -eq 0 ]; then
	echo "Docker package is not installed yet. Installing Docker package..."
	sudo apt-get update
	sudo dpkg -i "$DOCKER_PATH"
else
	echo "Docker package is already installed"
fi

# moves docker volumes to DOCKER_MNT, in order to preserve OS disk
sudo systemctl stop docker
sudo mv /var/lib/docker/volumes $DOCKER_MNT
sudo ln -s $DOCKER_MNT/volumes /var/lib/docker/volumes
sudo systemctl start docker
