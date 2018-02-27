#!/bin/sh

# set some constants
docker_images="\
  metasploitframework/metasploit-framework:latest \
  postgres:latest \
"

k8s_dir="../deployments/k8s/metasploit"

eval $(minikube docker-env)

# ensure the image is available to minikube's docker daemon
# ... seems to be some bug there (or more likely was just taking forever)
for docker_image_name in $docker_images
do
  docker pull "$docker_image_name"
done

# apply 'metasploit' namespace
kubectl apply -f "$k8s_dir"

# apply metasploit framework service/deployment
kubectl apply -f "$k8s_dir/metasploit-framework"

# apply postgres statefulset to use with metasploit framework
kubectl apply -f "$k8s_dir/metasploit-postgres"
