#!/bin/bash
        #THIS IS A BASH SCRIPT TO DEPLOY MY WEB APP

#VARS
HOME_DIR=/home/ec2-user
SECRET_KEY=${HOME_DIR}/key
PIPLINE_WORKSPACE=/var/lib/jenkins/workspace/final-project

if len(sys.argv) != 2:
    print('please enter one argument')
    sys.exit()

machine_name=$1


ssh -i $SECRET_KEY -o StrictHostKeyChecking=no $machine_name mkdir -p $HOME_DIR/final-project
scp -i $SECRET_KEY $PIPLINE_WORKSPACE/docker-compose.yml $machine_name:$HOME_DIR/final-project


