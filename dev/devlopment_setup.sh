#!/usr/bin/env bash

# Docker Compose
sudo apt install docker-compose
docker-compose -f docker-compose.halfstack.yml up -d
docker pull lablup/kernel-python:3.6-debian
sudo docker pull lablup/kernel-python:3.6-ubuntu
sudo docker pull lablup/kernel-python-tensorflow:1.12-py36
if [ $ENABLE_CUDA -eq 1 ]; then
  sudo docker pull lablup/kernel-python-tensorflow:1.12-py36-cuda9
fi

# goto manager
# cp sample-configs/image-metadata.yml image-metadata.yml
# cp sample-configs/image-aliases.yml image-aliases.yml
./scripts/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd update-images -f image-metadata.yml
./scripts/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd update-aliases -f image-aliases.yml

cp alembic.ini.sample alembic.ini

python3 -m ai.backend.manager.cli schema oneshot head
python3 -m ai.backend.manager.cli --db-addr=localhost:8100 --db-user=postgres --db-password=develove --db-name=backend fixture populate sample-configs/example-keypairs.json

# vfolder
mkdir ./vfolder
./scripts/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put volumes/_mount "./vfolder"
./scripts/run-with-halfstack.sh python3 -m ai.backend.manager.cli etcd put volumes/_default_host "local"

# key setting

export BACKEND_ENDPOINT=http://127.0.0.1:8081/
export BACKEND_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE
export BACKEND_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

mkdir scratches

