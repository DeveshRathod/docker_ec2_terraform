output "mumbai_instance_public_ip" {
  value = aws_instance.app_mumbai.public_ip
}

output "virginia_instance_public_ip" {
  value = aws_instance.app_virginia.public_ip
}

output "mumbai_lb_dns_name" {
  value = aws_lb.app_lb_mumbai.dns_name
}

output "virginia_lb_dns_name" {
  value = aws_lb.app_lb_virginia.dns_name
}
