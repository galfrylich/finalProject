pipeline {
    agent any 
    environment {
        DockerHubRegistryCredential =credentials('dockerhub')
        DockerHubRegistry = 'galfrylich/web-app'
        GitURL = 'https://github.com/galfrylich/finalProject'
        GitcredentialsId = 'e3494a8c-29b8-4649-8ff3-fa0a1d2c9b79'
    }
    stages {
        stage('Git Checkout') {
            steps {

                checkout([$class: 'GitSCM',
                 branches: [[name: '*/main']], 
                 extensions: [], 
                 userRemoteConfigs: [[credentialsId: "$GitcredentialsId",
                 url: "$GitURL"]]])
            }
        }
        stage('Build docker image') {
            steps {
                echo '# # # # # STAGE 2 - Build Image # # # # #'
                script{
                    dockerImage = docker.build("$DockerHubRegistry:latest")
                }
            }
        }
        stage('push image to dockerhub') {
            steps {
                script{
                    echo '# # # # # STAGE 3 - Push Image # # # # #'
                    withDockerRegistry([ credentialsId: "$DockerHubRegistryCredential", url: "" ]) {
                    dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy to test machine'){
            steps {
                echo '# # # # # STAGE 4 - Deploy to test machine # # # # #'
                sshagent(['ssh-key']) {
                   sh 'sudo chmod -R 755 ./deploy-project.sh'
                   sh '/var/lib/jenkins/workspace/final-project/deploy-project.sh te'
                   
                }
            }
        }
        stage('Deploy to production machine'){
            steps {
                echo '# # # # # STAGE 4 - Deploy to production machine # # # # #'
                sshagent(['ssh-key']) {
                   sh 'sudo chmod -R 755 ./deploy-project.sh'
                   input 'Deploy to Production?'
                   sh '/var/lib/jenkins/workspace/final-project/deploy-project.sh prod'
                }
            }
        }
        
    }
    post { 
        always { 
            echo 'I will always say Hello again!'
        }
    
    }
}



