node {
    stage("Checkout") {
        checkout scm
    }

    stage("Build") {
        docker.image('php:8.2-cli').inside('-u root') {
            sh 'curl -sS https://getcomposer.org/installer | php'
            sh 'mv composer.phar /usr/local/bin/composer'
            sh 'apt-get update && apt-get install -y unzip git'
            sh 'rm -f composer.lock'
            sh 'composer install --no-interaction --prefer-dist --optimize-autoloader'
        }
    }

    stage("Prepare Environment") {
        docker.image('php:8.2-cli').inside('-u root') {
            sh 'cp .env.example .env'
            sh 'php artisan key:generate'
        }
    }

    stage("Test") {
        docker.image('php:8.2-cli').inside('-u root') {
            sh 'php artisan test'
        }
    }
}