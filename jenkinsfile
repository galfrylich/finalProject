pipeline {
    agent any 
    stages {
        stage('checkout'){
            steps{
                script{
                    git 'https://github.com/galfrylich/finalProject'
                }
            }
        }
        stage('Example Build') {
            steps {
                echo 'Hello World'
            }
        }
    }
}


