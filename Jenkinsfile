pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        PORTAINER=credentials('portainer')
        PORTAINER_URL=credentials('portainer-url')
    }
    stages {
        stage('build') {
            steps {
                script {
                    img = docker.image('tmaier/docker-compose:latest')
                    img.inside('-v /var/run/docker.sock:/var/run/docker.sock') {
                        sh '/usr/bin/docker-compose build'
                    }
                }
            }
            post {
                success {
                    script {
                        def img = docker.image('greenled/portainer-stack-utils')
                        img.run('-v /var/run/docker.sock:/var/run/docker.sock -v .:/tmp/deploy -e PORTAINER_USER=${PORTAINER_USR} -e PORTAINER_PASSWORD=${PORTAINER_PSW} PORTAINER_URL=${PORTAINER_URL} PORTAINER_STACK_NAME=mmms DOCKER_COMPOSE_FILE=docker-compose.yaml PORTAINER_PRUNE=true ACTION=deploy')
                    }
                }
            }
        }
    }

}