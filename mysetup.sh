#!/bin/bash
sudo chown root:root logging/filebeat/filebeat.yml

export ELK_TAG="6.3.0"


    echo "------------------------------------------------------------"
    echo "############################### Creating separate docker network..."
    echo "------------------------------------------------------------"
    docker network create --subnet=172.16.0.0/24 monitoring_logging

    echo "------------------------------------------------------------"
    echo "############################### Pulling images..."
    echo "------------------------------------------------------------"
    /opt/bin/docker-compose -f monitoring/docker-compose.mysecure.yml pull
    /opt/bin/docker-compose -f logging/docker-compose.mysecure.yml pull

    echo "------------------------------------------------------------"
    echo "############################### Building images..."
    echo "------------------------------------------------------------"
    /opt/bin/docker-compose -f monitoring/docker-compose.mysecure.yml build
    /opt/bin/docker-compose -f logging/docker-compose.mysecure.yml build

    echo "------------------------------------------------------------"
    echo "############################### Starting monitoring and logging container groups..."
    echo "------------------------------------------------------------"
    /opt/bin/docker-compose -f monitoring/docker-compose.mysecure.yml up --force-recreate -d
    /opt/bin/docker-compose -f logging/docker-compose.mysecure.yml up --force-recreate -d

    echo "------------------------------------------------------------"
    echo "############################### Output from 'docker ps'..."
    echo "------------------------------------------------------------"
    docker ps

    echo "------------------------------------------------------------"
    echo "############################### Finished - you're all set up. Use mycleanup.sh to uninstall the suite."
    echo "------------------------------------------------------------"

