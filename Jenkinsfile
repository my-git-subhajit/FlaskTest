pipeline{
    agent any
    environment {
        USER = 'ubuntu'
        EC2_INSTANCE_IP = '13.51.72.188'
        KEY_PAIR = 'Mykey01'
    }
    stages{
        stage('Fetch code'){
            steps{
                git branch: 'main', url: 'https://github.com/my-git-subhajit/FlaskTest.git'
            }
        }

        stage('Running test case'){
            steps{
                sh 'pip install -r requirements.txt'
                sh 'chmod +x test_app.py'
                sh 'python3 test_app.py'
            }
        }
        stage('Build docker image'){
           steps{
             sh 'docker build -t iamgood1989/python-app:latest .'
           }
        }
        stage('push to dockerhub'){
           steps{
             sh 'docker push iamgood1989/python-app:latest'
           }
        }
        stage('Deploy') {
            steps {
                script {
                    sshagent(credentials:['ec2']) {
                        sh "scp -o StrictHostKeyChecking=no -i ${KEY_PAIR}.pem Dockerfile ${USER}@${EC2_INSTANCE_IP}:~/"
                        sh "scp -o StrictHostKeyChecking=no -i ${KEY_PAIR}.pem -r * ${USER}@${EC2_INSTANCE_IP}:~/"
                        sshCommand remote: "${USER}@${EC2_INSTANCE_IP}", command: "sudo docker run -d -p 3000:3000 iamgood1989/python-app:latest"
                    }
                }
            }
        }
    }
}
