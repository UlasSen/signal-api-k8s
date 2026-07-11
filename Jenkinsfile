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
                // Bozuk cache'i atlamak için --no-cache parametresini ekledik
                sh 'docker build --no-cache -t signal-api .'
            }
        }
        
        stage('Minikube Injection (SRE Hack)') {
            steps {
                sh '''
                    docker save signal-api:latest > image.tar
                    docker exec -i minikube docker load < image.tar || docker exec -i minikube ctr -n k8s.io images import - < image.tar
                    
                    # İşimiz biten devasa tar dosyasını siliyoruz (Temizlik)
                    rm -f image.tar
                '''
            }
        }
        
        stage('Kubernetes Deploy (SRE Hack)') {
            steps {
                sh '''
                    docker exec -i minikube sh -c "if [ ! -f /usr/local/bin/kubectl ]; then curl -sLO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/local/bin/; fi"
                    
                    cat deployment.yaml | docker exec -i minikube kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f -
                    cat service.yaml | docker exec -i minikube kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f -
                '''
            }
        }
    }
}