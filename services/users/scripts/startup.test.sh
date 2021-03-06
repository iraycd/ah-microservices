#!/bin/bash

set -ex

# Create Database
# shellcheck disable=SC1091
source /home/database/postgres-create.sh

until nc -z -v -w30 kafka 9092
do
  echo "Waiting for kafka to start..."
  sleep 5
done

cd "$GOPATH/src/github.com/agave/ah-microservices/services/users" && make test
