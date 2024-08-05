pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Anjali08Patel/Docker_codespace.git'
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
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t hello-world-app .'
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
    }
}
