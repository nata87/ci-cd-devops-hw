pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: default
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.16.0-debug
      imagePullPolicy: Always
      command:
        - sleep
      args:
        - 99d
"""
    }
  }

  environment {
    ECR_REGISTRY = "495671352321.dkr.ecr.us-west-2.amazonaws.com"
    IMAGE_NAME   = "lesson-5-ecr"
    IMAGE_TAG    = "${env.BUILD_NUMBER}"
  }

  stages {
    stage('Build & Push Docker Image') {
      steps {
        container('kaniko') {
          withCredentials([usernamePassword(credentialsId: '4087ff39-0114-475d-b6f3-926b6fd116c8', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh '''
              # Створюємо конфігурацію для Kaniko
              mkdir -p /kaniko/.docker
              echo "{\\"auths\\":{\\"$ECR_REGISTRY\\":{\\"auth\\":\\"$(echo -n $AWS_ACCESS_KEY_ID:$AWS_SECRET_ACCESS_KEY | base64)\\"}}}" > /kaniko/.docker/config.json
              
              # Запускаємо збірку з відносним шляхом до Dockerfile
              /kaniko/executor \
                --context `pwd` \
                --dockerfile Dockerfile \
                --destination=$ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG \
                --cache=true \
                --insecure \
                --skip-tls-verify
            '''
          }
        }
      }
    }
    
    stage('Update Manifest') {
      steps {
        container('jnlp') {
          withCredentials([usernamePassword(credentialsId: 'ba1a3fa7-cce9-4ae5-9aaf-92dca2826c73', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
            script {
              sh "sed -i 's|tag:.*|tag: \"${IMAGE_TAG}\"|' helm-chart/django-app/values.yaml"
              sh "git config user.email 'jenkins@jenkins.com'"
              sh "git config user.name 'Jenkins'"
              sh "git remote set-url origin https://${GIT_USER}:${GIT_TOKEN}@github.com/nata87/ci-cd-devops-hw.git"
              sh "git add helm-chart/django-app/values.yaml"
              sh "git commit -m 'Jenkins update image tag to ${IMAGE_TAG}'"
              sh "git push origin main"
            }
          }
        }
      }
    }
  }
}