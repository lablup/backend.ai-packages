#!/usr/bin/env bash

# Add key
cat /usr/local/backend.ai/backend.ai.gpg.key | sudo apt-key add -

# Add sources.list
sudo echo "deb file:///usr/local/backend.ai/ubuntu18.04/backend.ai-client bionic main" >> /etc/apt/sources.list
sudo echo "deb file:///usr/local/backend.ai/ubuntu18.04/backend.ai-common bionic main">> /etc/apt/sources.list
sudo echo "deb file:///usr/local/backend.ai/ubuntu18.04/backend.ai-manager bionic main" >> /etc/apt/sources.list
sudo echo "deb file:///usr/local/backend.ai/ubuntu18.04/backend.ai-agent bionic main" >> /etc/apt/sources.list

sudo apt update
