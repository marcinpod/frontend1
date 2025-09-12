pipeline {
  agent {
    label 'angular-builder'
  }

  environment {
    BUILD_DIR = "dist/frontend1/browser"
    DEPLOY_DIR = "/mnt/apps/temp-build/frontend1"
  }

  stages {

    stage('Diagnostyka Docker Socket') {
      steps {
        sh '''
          echo "User info:"
          id

          echo "Uprawnienia do /var/run/docker.sock:"
          ls -l /var/run/docker.sock

          echo "Sprawdzenie grupy docker:"
          getent group docker || echo "Grupa docker nie istnieje"

          echo "Grupy użytkownika jenkins:"
          groups jenkins || echo "Użytkownik jenkins nie istnieje lub brak grup"

          echo "Test dostępu do docker socket:"
          if [ -S /var/run/docker.sock ]; then
            echo "Socket istnieje i jest typu socket"
          else
            echo "Socket nie istnieje lub nie jest socketiem"
          fi
        '''
      }
    }

    stage('Check permissions') {
      steps {
        sh '''
          echo "User inside container:"
          id

          echo "Listing /mnt/apps and /mnt/apps@tmp:"
          ls -ld /mnt/apps /mnt/apps@tmp || echo "Directory /mnt/apps@tmp does not exist"
        '''
      }
    }

    stage('Klonowanie Repozytorium') {
      steps {
        echo "Kod został pobrany z repozytorium."
        sh 'ls -la'
      }
    }

    stage('Instalacja zależności') {
      steps {
        dir('frontend1') {
          sh 'npm install'
        }
      }
    }

    stage('Build aplikacji Angular') {
      steps {
        dir('frontend1') {
          sh 'npm run build'
        }
      }
    }

    stage('Sprawdzenie builda') {
      steps {
        echo "Zawartość katalogu dist/frontend1/browser:"
        sh 'ls dist/frontend1/browser -l'
      }
    }

    stage('Kopiowanie plików do katalogu tymczasowego na VPS') {
      steps {
        sh '''
          rm -rf /mnt/apps/temp-build/frontend1
          mkdir -p /mnt/apps/temp-build/frontend1/dist
          cp -r dist/frontend1/browser/* /mnt/apps/temp-build/frontend1/dist/
          cp Dockerfile /mnt/apps/temp-build/frontend1/
        '''
      }
    }

    stage('Budowanie i uruchamianie kontenera') {
      steps {
        dir('/mnt/apps') {
          sh 'docker compose up -d --no-deps --build frontend1'
        }
      }
    }
  }

  post {
    always {
      echo 'Pipeline zakończony.'
    }
    failure {
      echo 'Wystąpił błąd podczas procesu CI/CD.'
    }
  }
}
