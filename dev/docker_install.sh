#!/usr/bin/env bash

sudo apt install curl -y

# Docker
curl -fsSL https://get.docker.com/ | sudo sh
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo usermod -aG docker $USER
