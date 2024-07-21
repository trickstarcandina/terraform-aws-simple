#!/bin/bash
sudo yum update -y
# install docker
sudo yum install docker -y
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
sudo chmod -v +x /usr/local/bin/docker-compose
sudo systemctl enable docker.service
sudo systemctl start docker.service
# install git
sudo yum install git -y
git clone ...
cd ...
# build code
sudo docker-compose up -d --build