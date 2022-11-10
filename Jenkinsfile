pipeline {
    agent any 
    environment {
        DockerHubRegistryCredential =credentials('dockerhub')
        DockerHubRegistry = 'galfrylich/web-app'
        GitURL = 'https://hub.docker.com/repository/docker/yossibenga/flask_app'
        GitcredentialsId = '90a24bb8-70d5-4b6c-8c60-35de22dc627f'
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
        post { 
        always { 
            echo 'I will always say Hello again!'
        }
    }

        
    }
    
}



