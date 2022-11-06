#!/bin/bash


###########THIS IS A BASH SCRIPT TO DEPLOY MY WEB APP######

#VARS#
HOME_DIR=/home/ec2-user
PIPLINE_WORKSPACE=/var/lib/jenkins/workspace/final-project

if [ $# -lt 1 ]; then
    echo "please enter one argument"
    exit 1
fi

    
   

machine_name=$1


ssh -o StrictHostKeyChecking=no -l ec2-user $machine_name -p $HOME_DIR/final-project
scp  $PIPLINE_WORKSPACE/docker-compose.yml $machine_name:$HOME_DIR/final-project
ssh -o StrictHostKeyChecking=no -l ec2-user $machine_name cd $HOME_DIR/finale-project docker system prune -a --volumes -f
ssh -o StrictHostKeyChecking=no -l ec2-user $machine_name cd $HOME_DIR/finale-project docker-compose up -d


