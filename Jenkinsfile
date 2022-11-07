pipeline {
    agent any 
    environment {
        dockerhub=credentials('dockerhub')

    }
    stages {
        stage('Git Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                 branches: [[name: '*/main']], 
                 extensions: [], 
                 userRemoteConfigs: [[credentialsId: 'e3494a8c-29b8-4649-8ff3-fa0a1d2c9b79',
                 url: 'https://github.com/galfrylich/finalProject']]])
            }
        }
        stage('Build docker image') {
            steps {
                script{
                    dockerImage = docker.build("galfrylich/web-app:latest")
                }
            }
        }
        stage('push image to dockerhub') {
            steps {
                script{
                    withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                    dockerImage.push()
                    }
                }
            }
        }
        stage('connect to test machine'){
            steps {
                sshagent(['ssh-key']) {
                   sh 'sudo chmod -R 577 ./deploy-project.sh'
                   sh '/var/lib/jenkins/workspace/final-project/deploy-project.sh test'
                   
                }
            }
        }
        stage('connect to production machine'){
            steps {
                sshagent(['ssh-key']) {
                   sh 'sudo chmod -R 577 ./deploy-project.sh'
                   sh '/var/lib/jenkins/workspace/final-project/deploy-project.sh prod'
                }
            }
        }
        
    }
    
}



