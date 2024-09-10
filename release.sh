#!/bin/bash

set -e
set -u

echo "Login to Docker Hub"

docker login -u $DOCKER_USER -p $DOCKER_PWD
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

# ----------------------------------------openresty----------------------------------------
echo "Release docker:openresty-alpine"
docker build -f Dockerfile.openresty.alpine -t  zhiqiangwang/docker:openresty-alpine  .
docker push zhiqiangwang/docker:openresty-alpine
# ----------------------------------------openresty----------------------------------------


# ----------------------------------------ssh----------------------------------------
echo "Release docker:ubuntu-ssh"
docker build -f Dockerfile.ubuntu.ssh -t  zhiqiangwang/docker:ubuntu-ssh  .
docker push zhiqiangwang/docker:ubuntu-ssh
# ----------------------------------------ssh----------------------------------------



# ----------------------------------------Xray----------------------------------------
xray_version=$(curl --silent "https://api.github.com/repos/XTLS/Xray-core/tags" | jq -r '.[0].name')
xray_current_version=$(cat xray/version)
if [[ $xray_version =~ ^v ]]; then
  xray_version=${xray_version#v}
fi
echo "xray current version:${xray_current_version}  Online version:${xray_version}"
if [[ "$xray_version" != "$xray_current_version" ]]; then
  docker build -build-arg="XRAY_TAG=${xray_version}" -f Dockerfile.xray -t  zhiqiangwang/docker:xray  .
  docker push zhiqiangwang/docker:xray
  echo "$xray_version" > xray/version
  git add xray/version
  git commit -a -m "Auto Update xray to tag: ${xray_version}"
fi
# ----------------------------------------Xray----------------------------------------


# ----------------------------------------v2ray----------------------------------------
echo "Comparing v2ray versions"
v2ray_version=$(curl --silent "https://api.github.com/repos/v2fly/v2ray-core/tags" | jq -r '.[0].name')
v2ray_current_version=$(cat v2ray/version)
if [[ $v2ray_version =~ ^v ]]; then
  v2ray_version=${v2ray_version#v}
fi
echo "V2ray current version:${v2ray_current_version}  Online version:${v2ray_version}"
# 判断版本号是否相同 如果相同就exit
if [[ "$v2ray_version" != "$v2ray_current_version" ]]; then
  docker build --build-arg="V2RAY_TAG=${v2ray_version}" -f Dockerfile.v2ray -t zhiqiangwang/docker:v2ray .
  docker push zhiqiangwang/docker:v2ray
  echo "$v2ray_version" >v2ray/version
  git add v2ray/version
  git commit -a -m "Auto Update v2ray to tag: ${v2ray_version}"
fi
# ----------------------------------------v2ray----------------------------------------



git push origin main