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
                    // Create Docker volume for Dockerfile
                    sh 'docker volume create my-vol'
                    // Use a temporary container to copy the Dockerfile into the volume
                    sh '''
                    docker run --rm \
                        -v my-vol:/vol \
                        -v $PWD:/workspace \
                        busybox sh -c "cp /workspace/Dockerfile /vol/"
                    '''
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Use the Dockerfile from the volume to build the Docker image
                    sh '''
                    docker build -t hello-world-app \
                        -f /var/lib/docker/volumes/my-vol/_data/Dockerfile \
                        .
                    '''
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
                    // Create Docker volume for JAR files
                    sh 'docker volume create my-jars'
                    // Use a temporary container to copy the JAR file into the volume
                    sh '''
                    docker run --rm \
                        -v my-vol:/vol \
                        -v my-jars:/jars \
                        busybox sh -c "cp /vol/target/my-java-project-1.0-SNAPSHOT.jar /jars/"
                    '''
                }
            }
        }
        stage('Use JAR File in Another Container') {
            steps {
                script {
                    // Run another container and use the JAR file from the volume
                    sh 'docker run --rm -v my-jars:/app my-app-image java -jar /app/my-java-project-1.0-SNAPSHOT.jar'
                }
            }
        }
    }
}
