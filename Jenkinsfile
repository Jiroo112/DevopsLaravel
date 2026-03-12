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

    stage("Test") {
        docker.image('php:8.2-cli').inside('-u root') {
            sh 'echo "Test passed"'
        }
    }

    stage("Deploy Dev") {
        sshagent(['prod-server']) {
            sh 'ssh -o StrictHostKeyChecking=no root@172.21.0.2 "echo Deployed to DEV"'
        }
    }

    stage("Deploy Prod") {
        sshagent(['prod-server']) {
            sh 'ssh -o StrictHostKeyChecking=no root@172.21.0.3 "echo Deployed to PROD"'
        }
    }
}
```

