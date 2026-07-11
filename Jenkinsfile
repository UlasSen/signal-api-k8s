pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Docker Build') {
            steps {
                sh 'docker build -t signal-api .'
            }
        }
        
        stage('Minikube Image Load') {
            steps {
                sh 'minikube image load signal-api'
            }
        }
        
        stage('Kubernetes Deploy') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }
    }
}