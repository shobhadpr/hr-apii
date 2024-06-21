pipeline {
    agent any

    stages {
        stage('git checkout') {
            steps {
                git branch: 'main', credentialsId: 'Github-creds', url: 'https://github.com/shobhadpr/hr-apii'
            }
            
        }
        stage('maven build') {
            steps {
                sh 'mvn clean package'
            }
            
        }
        stage('Docker build') {
            steps {
                script{
                   def tag = sh returnStdout: true, script: 'git log --oneline -1 | awk \'{print $1}\''
                   sh 'docker build -t 776550/hr-api:${tag} .'
                }
            }
            
        }
    }
}
