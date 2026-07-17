pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    // Команда для збірки вашого Docker-образу
                    sh 'docker build -t my-app:${BUILD_NUMBER} .'
                }
            }
        }
        stage('Push') {
            steps {
                // Команда для авторизації в ECR та відправки образу
                script {
                    sh 'aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin <ВАШ_ECR_URL>'
                    sh 'docker tag my-app:${BUILD_NUMBER} <ВАШ_ECR_URL>/my-app:${BUILD_NUMBER}'
                    sh 'docker push <ВАШ_ECR_URL>/my-app:${BUILD_NUMBER}'
                }
            }
        }
    }
}