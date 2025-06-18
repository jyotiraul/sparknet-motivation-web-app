# Empowerment Hub

A Flask-based Motivational Web Application implementing DevOps methodologies such as containerization, IaC, CI/CD, Kubernetes deployment, and cloud monitoring.

## 📁 Project Structure

```
motivation-web-app
├── .github
|   ├──workflows
|       ├──deploy.yaml
├── app
│   ├── __init__.py
│   ├── routes.py
│   ├── templates
│   │   ├── base.html
│   │   ├── index.html
│   │   ├── about.html
│   │   ├── quotes.html
│   │   ├── blog.html
│   │   └── contact.html
│   └── static
│       ├── css
│       │   └── styles.css
│       └── js
├── certificate
|   └── cluster-issuer.yaml
|   └── documentation
|         └──MotivationWebApp_Phase1_Documentation.pdf 
|         └──motivation-webapp-phase2-aws-eks.pdf   # Deployment reference for AWS EKS setup
├── k8s/                 # Kubernetes deployment files
│   └── deployment.yml
|   ├── service.yml
|   └── ingress.yml
├── infra/                   # Infrastructure as Code (Terraform)
|   └── ec2_setup.sh         
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── .gitignore              # Git ignore rules
├── Dockerfile              # Docker container- flask application
├── requirements.txt    
├── run.py
└── README.md
```


---

## 🧰 Tech Stack

| Component        | Technology       |
|------------------|------------------|
| Web Framework    | Flask (Python)   |
| UI               | HTML5, CSS3, JavaScript |
| Containerization | Docker           |
| Orchestration    | Kubernetes (AWS EKS)|
| CI/CD            | GitHub Actions   |
| IaC              | Terraform        |
| Cloud Platform   | AWS (EC2, EKS, Route 53) |
| Monitoring       | Prometheus, Grafana |
| VCS & IDE        | Git, GitHub, VS Code |

---

## 🛠️ Setup & Installation

### 1️⃣ Local Setup

```bash
# Clone the repository
git clone https://github.com/sparknet-innovations/motivation-web-app.git
cd motivation-web-app

# Create and activate virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the app
python run.py

# Access the app
Visit http://127.0.0.1:5000
```

---

## 🐳 Dockerization

###  Dockerization of the Flask Application 

```bash
# Build Docker image
docker build -t motivation-web-app .

# Run container
docker run -p 5000:5000 motivation-web-app
```

### Docker Hub

```bash
# Push to Docker Hub
docker login
docker tag motivation-web-app rauljyoti/motivation-web-app:latest
docker push rauljyoti/motivation-web-app:latest

# Pull and run from Docker Hub (Verify image)
docker pull rauljyoti/motivation-web-app:latest
docker run -d -p 5000:5000 rauljyoti/motivation-web-app:latest
```

---

## Phase II: Advanced DevOps Enhancements
 
---

## 1. Create AWS Infrastructure with Terraform
```bash
git clone https://github.com/jyotiraul/sparknet-motivation-web-app
cd infra   # run terraform commands here
terraform init
terraform validate
terraform plan
terraform apply

```

## 2. Connect to EC2 Instance
```bash
ssh -i "path/to/your-key.pem" ubuntu@<EC2-PUBLIC-IP>
```

## 3. Configure AWS CLI
```bash
aws configure
```

## 4. Update kubeconfig for EKS Cluster
```bash
aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
```

## 5. Apply Deployment and Service Files
```bash
nano deployment.yaml
nano service.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get po
kubectl get svc
```

## 6. Use a custom domain with SSL 
 Register a domain- Navigate to AWS Route 53, then go to Registered Domains and click on Register Domain Select domain and click on procced to checkout.


## 7. Add cert-manager policy 
```bash
{ 
  "Version": "2012-10-17", 
  "Statement": [ 
    { 
      "Effect": "Allow", 
      "Action": [ 
        "route53:GetChange", 
        "route53:ChangeResourceRecordSets", 
        "route53:ListResourceRecordSets", 
        "route53:ListHostedZones" 
      ], 
      "Resource": "*" 
    } 
  ] 
} 
```

## 8. Set Up SSL with Let's Encrypt and cert-manager
```bash
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager --set installCRDs=true
```

## 9. Create AWS Credentials Secret for cert-manager
```bash
kubectl create secret generic route53-credentials-secret \
  --namespace cert-manager \
  --from-literal=aws_access_key_id=<YOUR_KEY_ID> \
  --from-literal=aws_secret_access_key='<YOUR_SECRET_KEY>'
```

## 10. Apply ClusterIssuer Configuration
```bash
nano cluster-issuer.yaml
kubectl apply -f cluster-issuer.yaml
```

## 11. Install NGINX Ingress Controller via Helm
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace \
  --set controller.ingressClass=nginx \
  --set controller.ingressClassResource.name=nginx
```

## 12. Apply Ingress Resource
```bash
nano ingress.yaml
kubectl apply -f ingress.yaml
kubectl get ingress
```

## 13. Set A Record in Route 53
Point your domain (e.g., `motivationapp.click`) to the Ingress `EXTERNAL-IP`.click to that IP via an A record.  

## 14. check certificate Ready 'true'
```bash
kubectl get svc ingress-nginx-controller -n ingress-nginx    #check external ip / cname will be same
nslookup web.motivationapp.click

kubectl get certificate 
```

## 15. Access the Web Application
```text
https://web.motivationapp.click/
```

## 16. CI/CD  using github action 
.github/workflows/deploy.yaml   #Create a GitHub Actions workflow.

Go to GitHub Repo > Settings > Secrets and variables > Actions > New repository secret, and add AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, DOCKER_PASSWORD, DOCKER_USERNAME, EKS_CLUSTER_NAME, KUBE_CONFIG.

## 17. Set Up Monitoring with Prometheus and Grafana
```bash
helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace prometheus
helm install prometheus-stack prometheus-community/kube-prometheus-stack -n prometheus
kubectl get pods -n prometheus
kubectl get svc -n prometheus
```

## 18. Expose Prometheus and Grafana
```bash
kubectl edit svc prometheus-stack-kube-prom-prometheus -n prometheus
kubectl edit svc prometheus-stack-grafana -n prometheus
#change type to LoadBalancer
```

## 19. Access Grafana UI
- Get LoadBalancer IP:
  ```bash
  kubectl get svc -n prometheus   #copy stable grafana cname and paste into the browser
  ```
- Open Grafana in browser
- Login: `admin / prom-operator`

## 20. Import Dashboards in Grafana
| Metric Type   | Dashboard Name                        | ID     |
|---------------|----------------------------------------|--------|
| CPU & Memory  | Node Exporter Full                    | 1860   |
| Request Count | Kubernetes Cluster Monitoring         | 6417   |
| Error Rates   | API / Web Service Monitoring          | 11074  |

## 21. Sample Prometheus Queries

- **Memory Usage %**
  ```promql
  100 - ((node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100)
  ```

- **Network Usage**
  ```promql
  rate(node_network_receive_bytes_total[5m])
  ```

- **CPU Usage %**
  ```promql
  100 - (avg by (instance)(irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
  ```
