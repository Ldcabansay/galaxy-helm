#!/usr/bin/env bash
set -e

# Make sure all pods have at least one ready
pods="$(kubectl get pods 2>&1 >/dev/null)"
if [[ $pods == *"No resources found"* ]]; then
  exit 1
fi
! echo "$(kubectl get pods)" |  awk '{if(NR>1)print $2}' | grep "^0/" > /dev/null

