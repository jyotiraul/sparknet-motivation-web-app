FROM jenkins/jenkins:lts

USER root

# Install required packages
RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    unzip \
    git \
    awscli \
    gnupg \
    software-properties-common \
    lsb-release

# Install Terraform
ENV TERRAFORM_VERSION=1.6.6
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip

# Allow Jenkins user to run Docker
RUN usermod -aG docker jenkins

#USER jenkins
