#!/bin/bash

### USAGE ###
###########THIS IS A BASH SCRIPT TO DEPLOY MY WEB APP
### Accepts one argument, the host name macine.######

#VARS#
HOME_DIR=/home/ec2-user
PIPLINE_WORKSPACE=/var/lib/jenkins/workspace/final-project
DIR_NAME=final-project
machine_name=$1

if [ $# -lt 1 ]; then
    echo "please enter one argument"
    exit 1
fi

# cnnecting to machine and create new dir
ssh -o StrictHostKeyChecking=no -l ec2-user $machine_name mkdir -p $HOME_DIR/$DIR_NAME
# copy docker compose to machine
scp $PIPLINE_WORKSPACE/docker-compose.yml ec2-user@$machine_name:$HOME_DIR/$DIR_NAME
# remove all images and containers
ssh ec2-user@$machine_name "cd /home/ec2-user/$DIR_NAME; docker system prune -a --volumes -f"
# run docker compose up
ssh ec2-user@$machine_name "cd /home/ec2-user/$DIR_NAME; docker-compose up -d"

if [ $machine_name == "test" ]; then 
   scp $PIPLINE_WORKSPACE/$DIR_NAME/tests/test.sh ec2-user@$machine_name:$HOME_DIR/$DIR_NAME
   ssh ec2-user@test "cd /home/ec2-user/$DIR_NAME/tests; ./test.sh " 
fi   





