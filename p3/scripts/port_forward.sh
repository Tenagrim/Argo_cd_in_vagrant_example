#!/bin/bash

export PATH=$PATH:/usr/local/bin

#while true; do kubectl port-forward --address 0.0.0.0 svc/$1 -n $4 $2:$3 >/dev/null 2>/dev/null; sleep 10; done
while true; do kubectl port-forward --address 0.0.0.0 svc/$1 -n $4 $2:$3 ; sleep 10; done