#!/usr/bin/env bash

# Add key
cat /usr/local/backend.ai/backend.ai.gpg.key | sudo apt-key add -

# Add sources.list

add_client_apt='deb file:///usr/local/backend.ai/ubuntu18.04/backend.ai-client bionic main'
add_common_apt='deb file:///usr/local/backend.ai/ubuntu18.04/backend.ai-common bionic main'
add_manager_apt='deb file:///usr/local/backend.ai/ubuntu18.04/backend.ai-manager bionic main'
add_agent_apt='deb file:///usr/local/backend.ai/ubuntu18.04/backend.ai-agent bionic main'

apt_sources_path='/etc/apt/sources.list'

apt_sources_list=$(cat $apt_sources_path)

if [[ $apt_sources_list != *"$add_client_apt"* ]]; then
    sudo echo "$add_client_apt" >> $apt_sources_path
fi

if [[ $apt_sources_list != *"$add_common_apt"* ]]; then
    sudo echo "$add_common_apt" >> $apt_sources_path
fi

if [[ $apt_sources_list != *"$add_manager_apt"* ]]; then
    sudo echo "$add_manager_apt" >> $apt_sources_path
fi

if [[ $apt_sources_list != *"$add_agent_apt"* ]]; then
    sudo echo "$add_agent_apt" >> $apt_sources_path
fi

sudo apt update
