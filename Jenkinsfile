pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Create Docker Volume') {
            steps {
                sh 'docker volume create my-vol'
            }
        }

        stage('Copy JAR to Docker Volume') {
            steps {
                sh 'docker run --rm -v my-vol:/mnt -v /var/lib/jenkins/workspace/docker-assignment-3/target:/app busybox sh -c "cp /app/my-java-project-1.0-SNAPSHOT.jar /mnt/my-app.jar"'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hello-world-app -f /var/lib/jenkins/workspace/docker-assignment-3/Dockerfile /var/lib/jenkins/workspace/docker-assignment-3'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d --name hello-world-container hello-world-app'
            }
        }

        stage('Create Directory and Copy JAR to New Directory') {
            steps {
                sh '''
                mkdir -p /var/lib/jenkins/workspace/new-directory
                docker run --rm -v my-vol:/mnt -v /var/lib/jenkins/workspace/new-directory:/new-directory busybox sh -c "cp /mnt/my-app.jar /new-directory/"
                '''
            }
        }

        stage('Copy JAR File to Another Container') {
            steps {
                sh '''
                docker run -d --name another-container hello-world-app
                docker cp /var/lib/jenkins/workspace/new-directory/my-app.jar another-container:/my-app.jar
                '''
            }
        }
    }
}
