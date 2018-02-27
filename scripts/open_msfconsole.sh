#!/bin/sh

podname=$(kubectl get po -n metasploit -l app=metasploit -o jsonpath='{.items[0].metadata.name}')

kubectl exec -it $podname -n metasploit /usr/src/metasploit-framework/msfconsole
