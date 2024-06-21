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
                   sh "docker build . -t 776550/hr-api:${tag} "
                }
            }
            
        }
        stage('Docker Push') {
            steps {
                script{
                    withCredentials([usernamePassword(credentialsId: 'Docker-hub', passwordVariable: 'pswd', usernameVariable: 'user')]) {
                       sh "docker login -u ${user} -p ${pswd}"
                    }
                    
                    def tag = sh returnStdout: true, script: 'git log --oneline -1 | awk \'{print $1}\''
                    sh "docker push 776550/hr-api:${tag}"
                }
            }
            
        }
        stage('Docker Deploy-DEV') {
            steps {
                sh "docker run -d -p 9090:8080 --name cicd 776550/hr-api:${tag}"
            }
            
        }
    }
}
