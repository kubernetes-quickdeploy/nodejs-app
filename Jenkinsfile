pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/kubernetes-quickdeploy/nodejs-app.git'
        GIT_BRANCH = 'main'
        CONTAINER_NAME = 'nodejs-app'
        NODE_IMAGE = 'node:16'
        APP_PORT = '3000'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing Node.js dependencies...'
                sh """
                docker run --rm \
                    -v ${env.WORKSPACE}:/usr/src/app \
                    -w /usr/src/app \
                    ${NODE_IMAGE} npm install
                """
            }
        }

        stage('Run Application') {
            steps {
                echo 'Running Node.js application in Docker container...'
                sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true

                docker run -d \
                    --name ${CONTAINER_NAME} \
                    -p ${APP_PORT}:3000 \
                    -v ${env.WORKSPACE}:/usr/src/app \
                    -w /usr/src/app \
                    ${NODE_IMAGE} node index.js
                """
            }
        }
    }

    post {
        success {
            echo "✅ Deployment succeeded!"
        }
        failure {
            echo "❌ Deployment failed."
        }
        always {
            echo "ℹ️  Pipeline execution complete."
        }
    }
}
