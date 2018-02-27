#!/bin/sh

# set some constants
docker_images="\
  vulnerables/web-dvwa:latest \
  mysql:latest
"

k8s_dir="../deployments/k8s/damn-vulnerable-web-app"

# use minikube docker daemon
eval $(minikube docker-env)

# ensure the image is available to minikube's docker daemon
# ... seems to be some bug there (or more likely was just taking forever)
for docker_image_name in $docker_images
do
  docker pull "$docker_image_name"
done

# apply webgoat namespace
kubectl apply -f "$k8s_dir/01-namespace.yaml"

# apply webgoat service/deployment
kubectl apply -f "$k8s_dir/dvwa"

# apply mysql service/deployment
kubectl apply -f "$k8s_dir/mysql"
