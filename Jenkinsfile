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
                    docker.build("mcpmappingsite:${env.BUILD_ID}")
                }
            }
        }
    }

}