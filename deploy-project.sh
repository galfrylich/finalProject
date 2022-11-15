#!/bin/bash

                 ### USAGE ###
### THIS IS A BASH SCRIPT TO DEPLOY MY WEB APP
### Accepts one argument, the host name machine.######

#VARS#
HOME_DIR=/home/ec2-user
PIPLINE_WORKSPACE=/var/lib/jenkins/workspace/final-project
DIR_NAME=final-project
machine_name=$1


if [ $# -ne 1 ]; then
    echo "please enter ONLY one argument \nArgument must be [prod | test]"
    exit 1
fi

check_args() {
    case "$machine_name" in
    "test") echo "Deploy to TEST machine" ;;
    "prod") echo "Deploy to PROD machine" ;;
    *)
        echo "ERROR! unknown argument ${machine}"
        echo "Usage is ./deploy.sh [prod | test]"
        exit 1
        ;;

    esac
}

main (){
    # Connecting to machine and create new dir
    echo "Connecting to $machine_name"
    ssh -o StrictHostKeyChecking=no -l ec2-user $machine_name mkdir -p $HOME_DIR/$DIR_NAME
    # Copy docker compose to machine
    echo "Copy docker-compose to $machine_name"
    scp $PIPLINE_WORKSPACE/docker-compose.yml ec2-user@$machine_name:$HOME_DIR/$DIR_NAME
    # remove all images and containers
    echo "Remove all containers and images"
    ssh ec2-user@$machine_name "cd /home/ec2-user/$DIR_NAME; docker-compose down -v"
    ssh ec2-user@$machine_name "cd /home/ec2-user/$DIR_NAME; docker system prune -a --volumes -f"
    echo "run docker compose up"
    ssh ec2-user@$machine_name "cd /home/ec2-user/$DIR_NAME; docker-compose up -d --no-build"

    ## DO TESTS IF YOUR IN TEST MACHINE ##
    if [ $machine_name == "test" ]; then 
        # copy script to test machine 
        echo "copy test.sh to TEST machine"
        scp /var/lib/jenkins/workspace/final-project/tests/test.sh ec2-user@$machine_name:$HOME_DIR/$DIR_NAME
        # give permissions to test.sh file
        ssh ec2-user@test "chmod u+x $HOME_DIR/$DIR_NAME/test.sh"
        # RUN TESTS
        echo "Running tests"
        ssh ec2-user@test "cd /home/ec2-user/$DIR_NAME; ./test.sh " 
    fi   

}
check_args
main $machine_name







