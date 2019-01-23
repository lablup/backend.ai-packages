#!/usr/bin/env bash

# Client #
sudo apt install backend.ai-client -y
sudo apt autoremove backend.ai-client -y

echo "check Please .... "
sleep 3

# Common #
sudo apt install backend.ai-common -y
sudo apt autoremove backend.ai-common -y

echo "check Please .... "
sleep 3

# Manager #
sudo apt install backend.ai-manager -y
sudo apt autoremove backend.ai-manager -y

echo "check Please .... "
sleep 3

# Agent #
sudo apt install backend.ai-agent -y
sudo apt autoremove backend.ai-agent -y

echo "Done ..!! "
