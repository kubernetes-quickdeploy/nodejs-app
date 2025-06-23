pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/yourusername/your-nodejs-repo.git'
        GIT_BRANCH = 'main'
        CONTAINER_NAME = 'nodejs-app'
        NODE_IMAGE = 'node:16'  // public Node.js image from Docker Hub
        APP_PORT = '3000'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Run Node.js Container') {
            steps {
                // Stop and remove any existing container with same name
                sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                """

                // Run container mounting local code and exposing port
                sh """
                docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:3000 -v \$(pwd):/usr/src/app -w /usr/src/app ${NODE_IMAGE} node index.js
                """
            }
        }
    }

    post {
        always {
            echo 'Deployment finished.'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
