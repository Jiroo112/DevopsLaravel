node {

    stage('Checkout') {
        checkout scm
    }

    stage('Build') {
        docker.image('composer:latest').inside('-u root') {
            sh 'rm -f composer.lock'
            sh 'composer install'
        }
    }

    stage('Testing') {
        docker.image('ubuntu').inside('-u root') {
            sh 'echo "Ini adalah test pipeline Jenkins"'
        }
    }

}