output "public_ip" {
  value = aws_instance.motivation_app.public_ip
}

output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.motivation_log_group.name
}