pipeline {
  agent {
    label 'nodejs_docker'
  }

  parameters {
    string(name: 'REPO_URL', defaultValue: 'https://github.com/PriyankaRavee/nodejs-frontend-backend.git', description: 'Git repository URL')
    string(name: 'BRANCH_NAME', defaultValue: 'dev', description: 'Branch to build')
  }

  environment {
    GIT_CREDENTIALS = 'd675dc8c-41f7-48a0-a691-4d9632e8adab'
    DOCKER_IMAGE = 'myapp:latest'
    CONTAINER_PORT = '3000'
  }

  stages {   

    stage('Clone') {
      steps {
        echo "Cloning ${params.REPO_URL} on branch ${params.BRANCH_NAME}"
        git branch: "${params.BRANCH_NAME}",
            credentialsId: "${env.GIT_CREDENTIALS}",
            url: "${params.REPO_URL}"
        sh 'ls -la'
      }
    }
  

    stage('code build') {
      steps {
        dir('backend') {
          sh 'npm install'
        }
      }
    }

    
    stage('Build Docker Image') {
      steps {
        dir('backend') {
          sh "docker build -t ${DOCKER_IMAGE} ."
        }
      }
    }

    stage('Run Container') {
      steps {
        dir('backend') {
          sh "docker run -d -p ${CONTAINER_PORT}:${CONTAINER_PORT} ${DOCKER_IMAGE}"
        }
      }
    }
  }

  post {
    success {
      echo '✅ Build and deployment succeeded!'
      emailext(
        subject: "✅ Jenkins Build Success: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
        body: """
          <p>Hi Priyanka,</p>
          <p>Your Jenkins pipeline for <strong>${env.JOB_NAME}</strong> completed successfully.</p>
          <p><strong>Branch:</strong> ${params.BRANCH_NAME}<br>
          <strong>Docker Image:</strong> ${DOCKER_IMAGE}</p>
          <p>Check the console output <a href="${env.BUILD_URL}">here</a>.</p>
          <p>– Jenkins</p>
        """,
        to: 'priyankacsengr@gmail.com'
      )
    }
    failure {
      echo '❌ Build failed. Check logs for details.'
    }
  }
}