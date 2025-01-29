pipeline {
    agent any

    environment {
        registryCredential = 'ecr:us-east-1:aws_cred'
        j_front = "381492291062.dkr.ecr.us-east-1.amazonaws.com/jenkins/j_front"
        j_back = "381492291062.dkr.ecr.us-east-1.amazonaws.com/jenkins/j_back"
        j_mysql = "381492291062.dkr.ecr.us-east-1.amazonaws.com/jenkins_mysql"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: "main", url: "https://github.com/pinnnacl/EMA.git"
            }
        }

        stage('Build App Image') {
            steps {                                
                script {
                    // Build images with the BUILD_NUMBER tag
                    dockerImageFront = docker.build( j_front + ":$BUILD_NUMBER", "frontend/")
                    dockerImageBack = docker.build( j_back + ":$BUILD_NUMBER", "backend/")
                    dockerImageDB = docker.build( j_mysql + ":$BUILD_NUMBER", "mysql/")

                    // Retag the images to 'latest' using the tag directly
                    sh "docker tag ${j_front}:$BUILD_NUMBER ${j_front}:latest"
                    sh "docker tag ${j_back}:$BUILD_NUMBER ${j_back}:latest"
                    sh "docker tag ${j_mysql}:$BUILD_NUMBER ${j_mysql}:latest"
            
                    // Remove the images with BUILD_NUMBER tag
                    sh "docker rmi ${dockerImageFront.id}"
                    sh "docker rmi ${dockerImageBack.id}"
                    sh "docker rmi ${dockerImageDB.id}"
                }                          
            }                                
        }

        stage('Login to ECR') {
            steps {
                script {
                    // Login to AWS ECR
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 381492291062.dkr.ecr.us-east-1.amazonaws.com'
                }
            }
        }

        stage('Upload Docker Images to ECR') {
            steps {
                script {
                    // Push Docker images to ECR
                    sh "docker push ${j_front}:latest"
                    sh "docker push ${j_back}:latest"
                    sh "docker push ${j_mysql}:latest"
                }
            }
        }

        stage('Deploy images in kubernets environment') {
            steps {
                script {
                    // Push Docker images to ECR
                    sh "docker push ${j_front}:latest"
                    sh "docker push ${j_back}:latest"
                    sh "docker push ${j_mysql}:latest"
                }
            }
        }

        stage('Deploy images in Kubernetes environment') {
            steps {
                script {
                    sh 'sudo kubectl apply -f kubernetes/'
                }
            }
        }
    }
}
