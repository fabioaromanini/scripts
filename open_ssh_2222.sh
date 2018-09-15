#!/bin/sh

# Server

sudo sed -ie 's/#Port 22/Port 2222\nPort 22/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

# On client-side, $HOME/.ssh/config should havve rules like:
#Host *
#	Port 2222"
