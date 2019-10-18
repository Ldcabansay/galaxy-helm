#!/usr/bin/env bash
set -e

cd galaxy

helm dependency update
helm install --name galaxy --set service.type=NodePort .

