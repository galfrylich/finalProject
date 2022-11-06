#!/bin/bash


###########THIS IS A BASH SCRIPT TO DEPLOY MY WEB APP
### accepts one argument, the host name macine.######

#VARS#
HOME_DIR=/home/ec2-user
PIPLINE_WORKSPACE=/var/lib/jenkins/workspace/final-project
machine_name=$1

if [ $# -lt 1 ]; then
    echo "please enter one argument"
    exit 1
fi



ssh -o StrictHostKeyChecking=no -l ec2-user $machine_name mkdir -p $HOME_DIR/final-project
scp $PIPLINE_WORKSPACE/docker-compose.yml ec2-user@$machine_name:$HOME_DIR/final-project
ssh ec2-user@test "cd /home/ec2-user/final-project; docker-compose up -d"
#ssh -o StrictHostKeyChecking=no -l ec2-user $machine_name cd $HOME_DIR/final-project && docker-compose up -d

