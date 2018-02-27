#!/bin/sh

eval $(minikube docker-env)

docker run -d \
  --name registry \
  --restart=always \
  -p 5000:5000 \
  registry:2
