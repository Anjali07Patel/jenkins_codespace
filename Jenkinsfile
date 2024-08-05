pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Anjali07Patel/jenkins_codespace.git'
            }
        }
        stage('Build with Maven') {
            steps {
                script {
                    docker.image('maven:3.8.1-jdk-11').inside {
                        sh 'mvn clean package'
                    }
                }
            }
        }
        stage('Create Docker Volume and Copy Dockerfile') {
            steps {
                script {
                    sh 'docker volume create my-vol'
                    sh 'cp Dockerfile /var/lib/docker/volumes/my-vol/_data/'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t hello-world-app -f /var/lib/docker/volumes/my-vol/_data/Dockerfile .'
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    sh 'docker run --rm hello-world-app'
                }
            }
        }
        stage('Copy JAR File to Another Container') {
            steps {
                script {
                    sh '''
                    docker volume create my-jars
                    docker run --rm -v my-vol:/vol -v my-jars:/jars busybox sh -c "cp /vol/my-maven-project-1.0-SNAPSHOT.jar /jars/"
                    '''
                }
            }
        }
        stage('Use JAR File in Another Container') {
            steps {
                script {
                    sh 'docker run --rm -v my-jars:/app my-app-image java -jar /app/my-maven-project-1.0-SNAPSHOT.jar'
                }
            }
        }
    }
}
