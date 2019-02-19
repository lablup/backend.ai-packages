#!/usr/bin/env bash

sudo apt install curl -y
# Docker
sudo curl -fsSL https://get.docker.io | bash
sudo usermod -aG docker $(whoami)
