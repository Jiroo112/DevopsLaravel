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

    stage('Deploy') {
        sh '''
            docker compose -f $WORKSPACE/docker-compose.yml down --remove-orphans
            docker rm -f laravel_mysql laravel_app laravel_nginx || true
            docker compose -f $WORKSPACE/docker-compose.yml up -d --build
            sleep 30
            docker exec laravel_app php artisan migrate --force
        '''
    }

}