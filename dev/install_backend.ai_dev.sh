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

# Docker registry setup
show_info "Configuring the Lablup's official Docker registry..."
./utils/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put config/docker/registry/index.docker.io "https://registry-1.docker.io"
./utils/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put config/docker/registry/index.docker.io/username "lablup"
./utils/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd rescan-images

# Virtual folder setup
show_info "Setting up virtual folder..."
mkdir -p "${INSTALL_PATH}/vfolder/local"
./utils/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put volumes/_mount "${INSTALL_PATH}/vfolder"
./utils/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put volumes/_default_host "local"
mkdir scratches

# DB schema
show_info "Setting up databases..."
python3 -m ai.backend.manager.cli schema oneshot head
python3 -m ai.backend.manager.cli --db-addr=localhost:8100 --db-user=postgres --db-password=develove --db-name=backend fixture populate ./sample-configs/example-keypairs.json


show_info "Installation finished."
show_note "Default API keypair configuration for test / develop:"
echo -e "> ${WHITE}export BACKEND_ENDPOINT=http://127.0.0.1:8081/${NC}"
echo -e "> ${WHITE}export BACKEND_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE${NC}"
echo -e "> ${WHITE}export BACKEND_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY${NC}"
