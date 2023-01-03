#!/usr/bin/env bash

docker build -t xmlstarlet_bc:v1 .
docker tag xmlstarlet_bc:v1 developerjoy/xmlstarlet_bc:v1
docker push developerjoy/xmlstarlet_bc:v1