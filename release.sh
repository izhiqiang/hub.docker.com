#!/bin/bash

set -e
set -u

echo "Login to Docker Hub"

docker login -u $DOCKER_USER -p $DOCKER_PWD

# openresty
echo "Release docker:openresty-alpine"
docker build -f Dockerfile.openresty.alpine -t  zhiqiangwang/docker:openresty-alpine  .
docker push zhiqiangwang/docker:openresty-alpine


echo "Release docker:docker:xray"
docker build -f Dockerfile.xray -t  zhiqiangwang/docker:xray  .
docker push zhiqiangwang/docker:xray

echo "Release docker:docker:v2ray"
docker build -f Dockerfile.v2ray -t  zhiqiangwang/docker:v2ray  .
docker push zhiqiangwang/docker:v2ray