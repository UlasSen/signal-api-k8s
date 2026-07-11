pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Kodu GitHub'dan çekiyoruz
                checkout scm
            }
        }
        
        stage('Docker Build') {
            steps {
                // Windows üzerinde Jenkins kurduğumuz için komutları 'bat' ile veriyoruz
                bat 'docker build -t signal-api .'
            }
        }
        
        stage('Minikube Image Load') {
            steps {
                // İmajı internette aramaması için Minikube'un içine atıyoruz
                bat 'minikube image load signal-api'
            }
        }
        
        stage('Kubernetes Deploy') {
            steps {
                // Uygulamayı K8s'e fırlatıyoruz
                bat 'kubectl apply -f deployment.yaml'
                bat 'kubectl apply -f service.yaml'
            }
        }
    }
}