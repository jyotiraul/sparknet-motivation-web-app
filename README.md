# Empowerment Hub

A Flask-based Motivational Web Application implementing DevOps methodologies such as containerization, IaC, CI/CD, Kubernetes deployment, and cloud monitoring.

## 📁 Project Structure

```
motivation-web-app
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
├── deploy/                 # Kubernetes deployment files
│   └── deployment.yml
|   ├── service.yml
|   └── ingress.yml
├── infra/                   # Infrastructure as Code (Terraform)
|   └── ec2_setup.sh         
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── jenkins/                # Jenkins pipeline configuration
│   └── Jenkinsfile
|   └── Dockerfile          #jenkins Dockerfile
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
| Orchestration    | Kubernetes (Minikube) |
| CI/CD            | Jenkins          |
| IaC              | Terraform        |
| Cloud Platform   | AWS (EC2, CloudWatch) |
| Monitoring       | CloudWatch       |
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

## ☸️ Kubernetes Deployment

Ensure Minikube and Docker Desktop are running.

```bash
# Start Minikube
minikube start

# Apply Kubernetes configs
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl apply -f ingress.yml

# Access service
minikube service motivation-service
```

---

## ⚙️  Establishing CI/CD Workflows 
---

## ☁️ Infrastructure as Code (Terraform)

### Files

- `main.tf`: Defines infrastructure resources (EC2, CloudWatch).
- `variables.tf`: Input variable declarations.
- `outputs.tf`: Outputs (e.g., EC2 public IP).

### Commands

```bash
terraform init       # Initialize Terraform
terraform validate   # Validate configuration
terraform plan       # Preview changes
terraform apply      # Apply configuration
```

---

### CI/CD with Jenkins / Jenkins Setup 

- Build Jenkins image:
  ```bash
  docker build -t my-jenkins-docker ./jenkins
  ```

- Run Jenkins container:
  ```bash
  docker run -d --name jenkins \
    -p 9090:8080 -p 50000:50000 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v jenkins_home:/var/jenkins_home \
    my-jenkins-docker
  ```

- Access Jenkins: [http://localhost:9090](http://localhost:9090)

### Plugins Required

- Git Plugin
- Docker Pipeline
- Pipeline Utility Steps
- AWS Credentials Plugin
- Workspace Cleanup Plugin
- SSH Agent Plugin

### Credentials Required: Dashboard-> Manage Jenkins-> Credentials ->  

- dockerhub
- github-token
- aws-credentials
- ec2-ssh-key


### Webhook Integration with GitHub (via Ngrok)

```bash
choco install ngrok
ngrok config add-authtoken <your_token>
ngrok http http://localhost:9090
```

Update GitHub webhook with ngrok URL.
Select project on github-> go to setting -> select webhook-> add webhook->
Payload url & content type ->  click on add webhook 

### Jenkinsfile Configuration

Create a pipeline job and use the `jenkins/Jenkinsfile`:

Click on new item-> select Pipeline -> add decription, click on  GitHub hook trigger for GITScm polling, pipeline script- add code which is present in jenkins/Jenkinsfile (Note: Copy the EC2 public IP obtained from Terraform and paste it into the EC2_PUBLIC_IP = '' field in the Jenkinsfile.) 
```

### Monitoring & Logs

Cloudwatch -> logs -> Log groups
AWS CloudWatch integration for:

- Logs
- Error tracking
- Performance monitoring

