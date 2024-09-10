## openresty

~~~
docker run -it --name openresty -p 80:80 -d zhiqiangwang/docker:openresty-alpine

docker run -it --name openresty -p 80:80 -e NGINX_CONF_PATH=/local/nginx.conf -d zhiqiangwang/docker:openresty-alpine

docker run -it --name openresty -p 80:80 -e NGINX_CONF_PATH="https://raw.githubusercontent.com/izhiqiang/hub.docker.com/main/openresty/nginx.conf/localfile.conf" -d zhiqiangwang/docker:openresty-alpine
~~~

## SSH Tunnel

~~~
//Local Run
docker run -it --name ubuntu-ssh -p 8022:22 -e SSH_USER=ubuntu -e SSH_PASSWORD=123456 -d zhiqiangwang/docker:ubuntu-ssh
//Create k8s deployment
kubectl apply -f  https://raw.githubusercontent.com/izhiqiang/hub.docker.com/main/k8s/deployment-ssh.yaml
~~~

## V2ray tunnel

~~~
//Local Run (default configuration)
docker run -it --name v2ray -p 10086:10086 -e V2RAY_VMESS_PORT=10086 -e V2RAY_CLIENT_ID=b831381d-6324-4d53-ad4f-8cda48b30811 -d zhiqiangwang/docker:v2ray
//Local Run (Custom Configuration File)
docker run -it --name v2ray -p 10086:10086 -v /your path/config.json:/etc/v2ray/config.json -d zhiqiangwang/docker:v2ray
//Create k8s deployment
kubectl apply -f  https://raw.githubusercontent.com/izhiqiang/hub.docker.com/main/k8s/deployment-v2ray.yaml
~~~

## xray tunnel

~~~
//Local Run (default configuration)
docker run -it --name xray -p 9000:9000 -e XRAY_VMESS_PORT=9000 -e XRAY_CLIENT_ID=b831381d-6324-4d53-ad4f-8cda48b30811 -d zhiqiangwang/docker:xray
//Local Run (Custom Configuration File)
docker run -it --name xray -p 9000:9000 /your path/config.json:/etc/xray/config.json -d zhiqiangwang/docker:xray
//Create k8s deployment
kubectl apply -f  https://raw.githubusercontent.com/izhiqiang/hub.docker.com/main/k8s/deployment-xray.yaml
~~~

