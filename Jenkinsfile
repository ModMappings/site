pipeline {
    agent {
        docker {}
    }
    stages {
        stage('fetch') {
            steps {
                checkout scm
            }
        }
        stage('build') {
            steps {
                script {
                    site=docker.build("modmappingsite:${env.BUILD_ID}")
                    site.tag("latest")
                }
            }
            post {
                success {
                    script {
                        def img = docker.image('tmaier/docker-compose:1.12')
                        img.inside('-v /var/run/docker.sock:/var/run/docker.sock')
                        {
                            sh '/usr/bin/docker-compose up -d --force-recreate --remove-orphans'
                        }
                    }
                }
            }
        }
    }

}