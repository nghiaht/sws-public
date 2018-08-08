#!/bin/bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)
cd ${SCRIPT_DIR}

docker-compose -p dev -f docker-compose.yml build
docker-compose -p dev -f docker-compose.yml up -d --remove-orphans

sleep 20

./init-db.sh
