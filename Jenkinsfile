pipeline {
    agent any 
    environment {
        dockerhub =credentials('dockerhub')
        DockerHubRegistry = 'galfrylich/web-app'
        GitURL = 'https://github.com/galfrylich/finalProject'
        GitcredentialsId = 'e3494a8c-29b8-4649-8ff3-fa0a1d2c9b79'
    }
    stages {
        stage('Git Checkout') {
            steps {
                echo '# # # # # STAGE 1 - Git checkout # # # # #'
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
                    withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
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
                   sh 'bash ./deploy-project.sh test'
                   
                }
            }
        }
        stage('Deploy to production machine'){
            steps {
                echo '# # # # # STAGE 5 - Deploy to production machine # # # # #'
                sshagent(['ssh-key']) {
                   sh 'sudo chmod -R 755 ./deploy-project.sh'
                   input(message:"Deploy to Production?",
				      ok: "yes")
                   sh 'bash ./deploy-project.sh prod'
                }
            }
        }
        
        
    }
    post { 
        success {
            echo 'Deploy succeeded!'
        }
        failure {
            emailext body: 'Something is wrong , check console output at ${BUILD_URL} ',
            subject: 'Failed Pipeline: ${PROJECT_NAME} - build #${BUILD_NUMBER}',
            to: 'galfrylich@gmail.com'
           
        }
    
    }
}



