#!/usr/bin/env bash
set -e

cd galaxy

helm dependency update
helm install --name galaxy --set service.type=NodePort --set webHandlers.replicaCount=${webHandlers_replicaCount:-1}  --set jobHandlers.replicaCount=${jobHandlers_replicaCount-1} .

cd ..
attempt_counter=0
sleep_between_attempts=5
max_time_to_wait_in_seconds=300
max_attempts=$(expr ${max_time_to_wait_in_seconds} / ${sleep_between_attempts})

echo "Waiting for Galaxy to load"
while ! bash healthcheck.sh ; do
    if [ ${attempt_counter} -eq ${max_attempts} ];then
      echo "Max attempts reached"
      exit 1
    fi

    printf '.'
    attempt_counter=$(($attempt_counter+1))
    sleep ${sleep_between_attempts}
done

port=$(bash port.sh)
echo "Galaxy started up on port ${port}, goto http://localhost:${port}"

