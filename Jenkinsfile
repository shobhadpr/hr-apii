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
    }
}
