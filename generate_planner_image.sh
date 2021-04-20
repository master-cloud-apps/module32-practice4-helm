#!/bin/bash
# -*- ENCODING: UTF-8 -*-

DOCKER_HUB_USER="amartinm82"

# planner image
docker build -t $DOCKER_HUB_USER/planner:v2.0 ./planner
docker push $DOCKER_HUB_USER/planner:v2.0

