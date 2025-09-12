pipeline {
  agent any

    stages {
    stage('Checkout Code') {
      steps {
        echo 'Checking out code from Git...'
                // Plik Jenkinsfile jest juz w repozytorium, wiec checkout jest automatyczny
            }
        }

        stage('Build Frontend') {
      steps {
        echo 'Building Angular application...'
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Build and Deploy Docker Image') {
      steps {
        echo 'Building Docker image and deploying...'
                sh "docker build -t frontend1:latest ."
                sh "docker compose up -d --force-recreate frontend1"
            }
        }
    }
}
