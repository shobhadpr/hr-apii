pipeline {
    agent any
    environment{
        TAG = "${getTag()}"
    }

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
                    sh "docker build . -t 776550/hr-api:${env.TAG} "
                }
            }
            
        }
        stage('Docker Push') {
            steps {
                script{
                    withCredentials([usernamePassword(credentialsId: 'Docker-hub', passwordVariable: 'pswd', usernameVariable: 'user')]) {
                       sh "docker login -u ${user} -p ${pswd}"
                    }
                      sh "docker push 776550/hr-api:${env.TAG}"
                    
                }
            }
            
        }
        stage('Docker Deploy-DEV') {
            steps {
                sshagent(['ec2-user']) {
                         sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.33.203 docker rm -f docker"
                         sh "ssh ec2-user@172.31.33.203 docker run -d -p 9090:8080 --name docker 776550/hr-api:${env.TAG}"
                }
                
            }
            
        }
    }
}
def getTag(){
    def tag = sh returnStdout: true, script: 'git log --oneline -1 | awk \'{print $1}\''
    return tag
}
