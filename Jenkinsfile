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
        
        stage('Minikube Injection (SRE Hack)') {
            steps {
                // İmajı diske kaydedip doğrudan Minikube konteynerinin içine enjekte ediyoruz
                sh '''
                    docker save signal-api:latest > image.tar
                    docker exec -i minikube docker load < image.tar || docker exec -i minikube ctr -n k8s.io images import - < image.tar
                '''
            }
        }
        
        stage('Kubernetes Deploy (SRE Hack)') {
            steps {
                // YAML dosyalarını okutup doğrudan Minikube içindeki kubectl'e fırlatıyoruz
                sh 'cat deployment.yaml | docker exec -i minikube kubectl apply -f -'
                sh 'cat service.yaml | docker exec -i minikube kubectl apply -f -'
            }
        }
    }
}