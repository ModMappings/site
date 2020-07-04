pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        PORTAINER=credentials('portainer')
        PORTAINER_URL=credentials('portainerurl')
    }
    stages {
        stage('build') {
            steps {
                script {
                    img = docker.image('tmaier/docker-compose:latest')
                    img.inside('-v /var/run/docker.sock:/var/run/docker.sock') {
                        sh '/usr/bin/docker-compose build --force-recreate'
                    }
                }
            }
            post {
                success {
                    script {
                        def img = docker.image('greenled/portainer-stack-utils')
                        img.inside('-v :/tmp/deploy -e PORTAINER_USER=${PORTAINER_USR} -e PORTAINER_PASSWORD=${PORTAINER_PSW} -e PORTAINER_URL=${PORTAINER_URL} -e PORTAINER_STACK_NAME=mmms -e DOCKER_COMPOSE_FILE=docker-compose.yaml -e PORTAINER_PRUNE=true -e ACTION=deploy') {}
                    }
                }
            }
        }
    }

}