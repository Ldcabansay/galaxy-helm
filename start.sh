#!/usr/bin/env bash
set -e

cd galaxy

helm dependency update
helm install --name galaxy --set service.type=NodePort --set webHandlers.replicaCount=${webHandlers_replicaCount:-1}  --set jobHandlers.replicaCount=${jobHandlers_replicaCount-1} .

