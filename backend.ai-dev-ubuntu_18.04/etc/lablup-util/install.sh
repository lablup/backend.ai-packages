#!/usr/bin/env bash

RED="\033[0;91m"
GREEN="\033[0;92m"
YELLOW="\033[0;93m"
BLUE="\033[0;94m"
CYAN="\033[0;96m"
WHITE="\033[0;97m"
LRED="\033[1;31m"
LGREEN="\033[1;32m"
LYELLOW="\033[1;33m"
LBLUE="\033[1;34m"
LCYAN="\033[1;36m"
LWHITE="\033[1;37m"
LG="\033[0;37m"
NC="\033[0m"

INSTALL_PATH="./"

show_info() {
  echo " "
  echo "${BLUE}[INFO]${NC} ${GREEN}$1${NC}"
}

sudo apt install -y curl
sudo apt-get install -y libssl-dev libreadline-dev libgdbm-dev zlib1g-dev libbz2-dev libsqlite3-dev libffi-dev

# Docker Compose
install_docker-compose() {
echo "Install docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
}

# NOTE: docker-compose enforces lower-cased project names
ENV_ID=$(LC_ALL=C tr -dc 'a-z0-9' < /dev/urandom | head -c 8)


# starting install backend.ai for development setting!! #

# Install Docker when it was not installed
if ! type "docker" >/dev/null 2>&1; then
    sudo curl -fsSL https://get.docker.io | bash
    sudo usermod -aG docker $(whoami)
fi

# Install Docker-Compose when it was not installed
if ! type "docker-compose" >/dev/null 2>&1; then
    show_info "Install docker-compose"
    install_docker-compose
fi

# Install postgresql, etcd packages via docker
show_info "Launching the docker-compose \"halfstack\"..."
sudo docker-compose -f ./docker-compose.halfstack.yml -p "${ENV_ID}" up -d
sudo docker ps | grep "${ENV_ID}"   # You should see three containers here.

check_snappy() {
local pkgfile=$(ls | grep snappy)
if [[ $pkgfile =~ .*\.tar.gz ]]; then
    # source build is required!
    sudo apt install -y "libsnappy-dev" "libsnappy-devel" "snappy"
fi
rm -f $pkgfile
}

check_snappy

python3 -m ai.backend.agent.kernel build-krunner-env ubuntu16.04
python3 -m ai.backend.agent.kernel build-krunner-env alpine3.8

# Docker registry setup
show_info "Configuring the Lablup's official Docker registry..."
./scripts/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put config/docker/registry/index.docker.io "https://registry-1.docker.io"
./scripts/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put config/docker/registry/index.docker.io/username "lablup"
./scripts/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd rescan-images

# Virtual folder setup
show_info "Setting up virtual folder..."
mkdir -p "${INSTALL_PATH}/vfolder/local"
./scripts/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put volumes/_mount "${INSTALL_PATH}/vfolder"
./scripts/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put volumes/_default_host "local"
mkdir scratches


# DB schema
show_info "Setting up databases..."
python3 -m ai.backend.manager.cli schema oneshot head
python3 -m ai.backend.manager.cli --db-addr=localhost:8100 --db-user=postgres --db-password=develove --db-name=backend fixture populate ./sample-configs/example-keypairs.json

show_info "Pre-pulling frequently used kernel images..."
echo "NOTE: Other images will be downloaded from the docker registry when requested.\n"
sudo docker pull lablup/python:2.7-ubuntu18.04
sudo docker pull lablup/python:3.6-ubuntu18.04
sudo docker pull lablup/python-tensorflow:1.12-py36
sudo docker pull lablup/python-pytorch:1.0-py36

