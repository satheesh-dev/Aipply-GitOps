 ## Implemented GitOps pipeline using ArgoCD and Kubernetes   

This project demonstrates deploying a React.js frontend + Java Spring Boot backend application with a PostgreSQL database into a Kubernetes cluster using Docker, Kubernetes manifests, and ArgoCD for GitOps automation.

It showcases real-world DevOps practices: containerization, Kubernetes orchestration, GitOps-driven deployments, and secure secret management.

## Tech Stack

1.Frontend: React.js
2.Backend: Java Spring Boot
3.Database: PostgreSQL
4.Containerization: Docker
5.Orchestration: Kubernetes (Minikube for local testing)
6.GitOps/CD: ArgoCD
7.Secrets Management: Kubernetes Secrets

## Project Structure
 ```
.
├── deployment.yaml            # Kubernetes Deployment & Service for frontend-backend
├── postgres-deployment.yaml   # PostgreSQL Deployment & Service
├── secrets.yaml               # DB credentials as Kubernetes Secret
├── README.md                  # Project documentation
└── Dockerfile                 # Backend app container build
```

## How to Run
1️⃣ Clone the Repository
  ```
git clone https://github.com/satheesh-dev/aipply-GitOps.git
cd aipply-GitOps
```
2️⃣ Start Minikube (or your cluster)
  ```
minikube start
```
3️⃣ Install ArgoCD (if not installed)
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
4️⃣ Access ArgoCD UI
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Open https://localhost:8080
 in your browser.
Default username: admin
Get password:
```
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
```
5️⃣ Create Namespace for the App
```
kubectl create namespace gitops-demo
```
6️⃣ Setup ArgoCD Application

*Go to ArgoCD UI → “New App”
*Point it to your GitHub repo
*Select gitops-demo namespace
*Sync the app

7️⃣ Check Running Pods
```
kubectl get pods -n gitops-demo
```
## Screenshots

[wsl-setup.png] <img width="1911" height="926" alt="Screenshot 2025-08-28 112835" src="https://github.com/user-attachments/assets/fb5303a9-923b-4e79-a3ec-97579a5b0078" />

[argocd-dashboard.png] <img width="503" height="442" alt="Screenshot 2025-08-28 113009" src="https://github.com/user-attachments/assets/363a3c60-ce87-42e0-a401-67b832006a29" />

[kubectl-get-pods.png] <img width="1010" height="187" alt="image" src="https://github.com/user-attachments/assets/2ba6631c-f145-4ef4-9584-157434c5fb72" /><img width="1451" height="678" alt="Screenshot 2025-08-27 122921" src="https://github.com/user-attachments/assets/415395f7-b957-4f50-8b5f-89b70b9a7c56" />

[dockerhub-repo.png]<img width="1919" height="945" alt="image" src="https://github.com/user-attachments/assets/c608fddd-8db6-48f8-bdcd-ecd78718c2c0" />

[app-ui] <img width="1896" height="963" alt="Screenshot 2025-08-22 124253" src="https://github.com/user-attachments/assets/8e60e188-82a1-4d8f-9213-b569678b21ed" />


## Author

Satheesh – Aspiring DevOps Engineer.
GitHub: https://github.com/satheesh-dev
LinkedIn: https://www.linkedin.com/in/satheesh-t-1b566a267
