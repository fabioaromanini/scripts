#!/bin/bash

# TODO:


DOCKER_VERSION="docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb"
DOCKER_RELEASE_TYPE="edge"
DOCKER_MACHINE_VERSION="v0.14.0"
DOCKER_MNT="/mnt/docker"

DOWNLOADS_DIR="$HOME/Downloads/workspace/"
FILE_NAME="$DOCKER_VERSION.deb"
DOCKER_PATH="$DOWNLOADS_DIR$FILE_NAME"
DOCKER_DOWNLOAD_PATH="https://download.docker.com/linux/ubuntu/dists/xenial/pool/$DOCKER_RELEASE_TYPE/amd64/$FILE_NAME"

if [ ! -d $DOCKER_MNT ]; then
	echo "Installation requires $DOCKER_MNT"
	exit 1
else
	echo "disk mounted"
fi

if [ ! -f $DOCKER_PATH ]; then
    echo "Docker pkg not found!"
	wget -P $DOWNLOADS_DIR $DOCKER_DOWNLOAD_PATH
else
    echo "Docker pkg found!"
fi

DOCKER_INSTALLED=$(sudo dpkg-query -l | grep "docker" | wc -l)

if [ $DOCKER_INSTALLED -eq 0 ]; then
	echo "Docker package is not installed yet. Installing Docker package..."
	sudo apt-get update
	sudo dpkg -i "$DOCKER_PATH"
else
	echo "Docker package is already installed"
fi

sudo usermod -aG docker $USER

#installs docker-machine
curl -L https://github.com/docker/machine/releases/download/$DOCKER_MACHINE_VERSION/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
    chmod +x /tmp/docker-machine &&
    sudo cp /tmp/docker-machine /usr/local/bin/docker-machine


# installs docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# autocomplete
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.20.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

sleep 2
sudo systemctl stop docker

if [ -f $DOCKER_MNT/docker-config ]; then
	echo "erasing previous docker_config dir..."
	sudo rm -rf $DOCKER_MNT/docker-config
fi

# moves dockerfiles to DOCKER_MNT, in order to preserve space in OS disk
sudo mkdir -p $DOCKER_MNT/docker-config/var/

sudo mv /var/lib/docker $DOCKER_MNT/docker-config/var/ && \
	sudo rm -rf /var/lib/docker && \
	sudo ln -s $DOCKER_MNT/docker-config/var/docker /var/lib/docker

sleep 5
sudo systemctl start docker
