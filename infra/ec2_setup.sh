#!/bin/bash
apt-get update -y
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
usermod -a -G docker ubuntu
docker run -d -p 5000:5000 rauljyoti/motivation-web-app:latest