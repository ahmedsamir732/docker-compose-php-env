#!/bin/bash

ip=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')

sed -i "/HOST_IP=.*/d" .env
echo "HOST_IP=$ip" >> .env

docker-compose up -d
