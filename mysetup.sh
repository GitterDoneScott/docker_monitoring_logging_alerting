#!/bin/bash
sudo chown root:root logging/filebeat/filebeat.yml

export ELK_TAG="6.6.1"

#load properties into environment
set -o allexport
source .env
set +o allexport

#replace variables in config file from environment
envsubst < ./logging/elastalert/config/elastalert.yaml.presub > ./logging/elastalert/config/elastalert.yaml


    echo "------------------------------------------------------------"
    echo "############################### Creating separate docker network..."
    echo "------------------------------------------------------------"
    docker network create --subnet=172.16.0.0/24 monitoring_logging

    echo "------------------------------------------------------------"
    echo "############################### Pulling images..."
    echo "------------------------------------------------------------"
    docker-compose -f monitoring/docker-compose.mysecure.yml pull
    docker-compose -f logging/docker-compose.mysecure.yml pull

    echo "------------------------------------------------------------"
    echo "############################### Building images..."
    echo "------------------------------------------------------------"
    docker-compose -f monitoring/docker-compose.mysecure.yml build
    docker-compose -f logging/docker-compose.mysecure.yml build

    echo "------------------------------------------------------------"
    echo "############################### Starting monitoring and logging container groups..."
    echo "------------------------------------------------------------"
    docker-compose -f monitoring/docker-compose.mysecure.yml up --force-recreate -d
    docker-compose -f logging/docker-compose.mysecure.yml up --force-recreate -d

    echo "------------------------------------------------------------"
    echo "############################### Output from 'docker ps'..."
    echo "------------------------------------------------------------"
    docker ps

    echo "------------------------------------------------------------"
    echo "############################### Finished - you're all set up. Use mycleanup.sh to uninstall the suite."
    echo "------------------------------------------------------------"

