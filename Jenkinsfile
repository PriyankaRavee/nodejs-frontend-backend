pipeline {
  agent {
    label 'nodejs_docker'
  }

  parameters {
    string(name: 'REPO_URL', defaultValue: 'https://github.com/PriyankaRavee/nodejs-frontend-backend.git', description: 'Git repository URL')
    string(name: 'BRANCH_NAME', defaultValue: 'dev', description: 'Branch to build')
  }

  environment {
  GIT_CREDENTIALS = 'git_credentials/******'
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
      echo 'Build and deployment succeeded!'
    }
    failure {
      echo 'Build failed. Check logs for details.'
    }
  }
}