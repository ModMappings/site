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
                        sh '/usr/bin/docker-compose build --no-cache'
                    }
                }
            }
            post {
                success {
                    script {
                        img = docker.image('tmaier/docker-compose:latest')
                        img.inside('-v /var/run/docker.sock:/var/run/docker.sock') {
                            sh '/usr/bin/docker-compose  -p mmmssite up -d --force-recreate'
                        }
                    }
                }
            }
        }
    }

}