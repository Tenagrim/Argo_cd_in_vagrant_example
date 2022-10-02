#!/bin/bash

export PATH=$PATH:/usr/local/bin

echo "[DEBUG] port forwarding launched: svc/$1 $2:$3"

#while true; do kubectl port-forward --address 0.0.0.0 svc/$1 -n $4 $2:$3 >/dev/null 2>/dev/null; sleep 10; done
while true; do kubectl port-forward --address 0.0.0.0 svc/$1 -n $4 $2:$3 ; sleep 10; done