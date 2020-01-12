pipeline {
    agent any
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
                        image('tmaier/docker-compose:1.12').inside(
                            'docker-compose up'
                        )
                    }
                }
            }
        }
    }

}