#!/bin/bash



    echo "------------------------------------------------------------"
    echo "############################### Stopping and removing containers..."
    echo "------------------------------------------------------------"
    /opt/bin/docker-compose -f monitoring/docker-compose.mysecure.yml down -v
    /opt/bin/docker-compose -f logging/docker-compose.mysecure.yml down -v

  echo "------------------------------------------------------------"
  echo "############################### Removing network..."
  echo "------------------------------------------------------------"
  docker network rm monitoring_logging

  echo "------------------------------------------------------------"
  echo "############################### Finished. Everything's cleaned up."
  echo "------------------------------------------------------------"


