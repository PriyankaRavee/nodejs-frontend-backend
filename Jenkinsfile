pipeline {
  agent {
  docker {
        image 'jenkins-node-docker-agent:latest'
        args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
}

  parameters {
    string(name: 'REPO_URL', defaultValue: 'https://github.com/PriyankaRavee/nodejs-frontend-backend.git', description: 'Git repository URL')
    string(name: 'BRANCH_NAME', defaultValue: 'dev', description: 'Branch to build')
  }

  environment {
    GIT_CREDENTIALS = '4fd73f02-722d-487f-9133-a86411df297e' //Jenkins credential ID
    DOCKER_IMAGE = 'myapp:latest'
    CONTAINER_PORT = '3000'
  }

  stages {
    stage('Clone') {
      steps {
        git branch: "${params.BRANCH_NAME}",
            credentialsId: "${env.GIT_CREDENTIALS}",
            url: "${params.REPO_URL}"
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'npm install'
      }
    }

    stage('Test') {
      steps {
        sh 'npm test'
      }
    }

    stage('Build Docker Image') {
        steps {
            sh "docker build -t ${DOCKER_IMAGE} ."
        }
    }


    stage('Run Container') {
        steps {
            sh "docker run -d -p ${CONTAINER_PORT}:${CONTAINER_PORT} ${DOCKER_IMAGE}"
        }
    }

  }

  post {
    success {
      echo ' Build and deployment succeeded!'
    }
    failure {
      echo 'Build failed Check logs for details.'
    }
  }
}