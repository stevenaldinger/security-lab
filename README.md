# Running Kubernetes locally with minikube

Download minikube [here](https://github.com/kubernetes/minikube/releases).

For Mac: [minikube-darwin-amd64](https://github.com/kubernetes/minikube/releases/download/v0.25.0/minikube-darwin-amd64)

`curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.25.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`

## Start up minikube

`minikube start`

`minikube start --docker-env dns=8.8.8.8`

## Get minikube IP

`minikube status`

## Show cluster context

`kubectl config current-context`

## Show all contexts

` kubectl config get-contexts`

# Deploy local Docker registry in Minikube VM

## Configure docker to use Minikube's daemon

Every docker command after this will be using Minikube's daemon.

`eval $(minikube docker-env)`

## Start running docker registry

This will pull down the registry server's image and make it available at the Minikube VM's `localhost:5000`

`docker run -d -p 5000:5000 --restart=always --name registry registry:2`

You can check the registry properly deployed with:

```sh
eval $(minikube docker-env)
docker ps -a
```

Which should return a table including something similar to this:

```
CONTAINER ID        IMAGE                                         COMMAND                  CREATED              STATUS              PORTS                    NAMES
5a004d09ea2c        registry:2                                    "/entrypoint.sh /etc…"   About a minute ago   Up 16 seconds       0.0.0.0:5000->5000/tcp   registry
```

## Run metasploit

1. `kubectl apply -f k8s/metasploit`
2. `kubectl apply -f k8s/metasploit/metasploit-postgres`
3. `kubectl apply -f k8s/metasploit/metasploit-framework`

### Start up msfconsole

```
podname=$(kubectl get po -n metasploit -l app=metasploit -o jsonpath='{.items[0].metadata.name}')

kubectl exec -it $podname -n metasploit /usr/src/metasploit-framework/msfconsole
```

# References

- [Run minikube on windows 10 with Hyper-V](https://medium.com/@JockDaRock/minikube-on-windows-10-with-hyper-v-6ef0f4dc158c)
- [Build your own lab](https://www.cyberstudents.org/blog-post/build-your-own-lab/)
- [OWASP WebGoat project](https://www.owasp.org/index.php/Category:OWASP_WebGoat_Project)
