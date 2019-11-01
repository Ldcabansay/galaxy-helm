#!/usr/bin/env bash
set -e

kubectl get services -o jsonpath='{..nodePort}'
