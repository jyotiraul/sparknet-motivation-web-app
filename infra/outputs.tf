output "public_ip" {
  description = "Public IP of the EC2 instance running the web app"
  value = aws_instance.motivation_app.public_ip
}

output "kubeconfig_command" {
  description = "Command to update local kubeconfig for EKS"
  value = "aws eks --region ${var.region} update-kubeconfig --name ${aws_eks_cluster.main.name}"
}

output "eks_cluster_endpoint" {
  description = "API server endpoint of the EKS cluster"
  value = aws_eks_cluster.main.endpoint
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value = aws_eks_cluster.main.name
}
