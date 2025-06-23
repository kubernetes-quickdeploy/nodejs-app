pipeline {
    agent any

    environment {
        IMAGE_NAME = 'nodejs-app'
        IMAGE_TAG = 'latest'
        APP_PORT = '3000'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/kubernetes-quickdeploy/nodejs-app.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove container if exists
                    sh "docker stop ${IMAGE_NAME} || true"
                    sh "docker rm ${IMAGE_NAME} || true"

                    // Run the container
                    sh """
                    docker run -d --name ${IMAGE_NAME} -p ${APP_PORT}:3000 ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Application deployed successfully!"
        }
        failure {
            echo "❌ Deployment failed!"
        }
    }
}
