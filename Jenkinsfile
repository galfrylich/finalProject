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
        stage('Build dokcer image') {
            steps {
                script{
                    sh 'docker build -t web-app .'
                }
            }
        }
        stage('push image to dockerhub') {
            steps {
                script{
                   withCredentials([string(credentialsId: 'docker-pwd', variable: 'docker-pwd')]) {
                   sh 'docker login -u galfrylich -p ${docker-pwd}'

                    } 
                   sh 'docker push galfrylich/web-app'   
                }
            }
        }
    }
}



