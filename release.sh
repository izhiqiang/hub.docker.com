#!/bin/bash

set -e
set -u

echo "Login to Docker Hub"

docker login -u $DOCKER_USER -p $DOCKER_PWD

# openresty
echo "Release docker:openresty-alpine"
docker build -f Dockerfile.openresty.alpine -t  zhiqiangwang/docker:openresty-alpine  .
docker push zhiqiangwang/docker:openresty-alpine