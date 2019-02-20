#!/usr/bin/env bash

if ! type "curl" >/dev/null 2>&1; then
    sudo apt install -y curl
fi

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:git-core/ppa
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
git lfs install
