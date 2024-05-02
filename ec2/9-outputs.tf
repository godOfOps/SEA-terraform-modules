output "elb_sg_id" {
  value = aws_security_group.elb_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.private_ec2_lt.id
}

output "launch_template_latest_version" {
  description = "Launch Template Latest Version"
  value       = aws_launch_template.private_ec2_lt.latest_version
}


output "autoscaling_group_id" {
  description = "Autoscaling Group ID"
  value       = aws_autoscaling_group.ec2_asg.id
}

output "autoscaling_group_name" {
  description = "Autoscaling Group Name"
  value       = aws_autoscaling_group.ec2_asg.name
}

output "autoscaling_group_arn" {
  description = "Autoscaling Group ARN"
  value       = aws_autoscaling_group.ec2_asg.arn
}

output "certificate_arn" {
  description = "Certificate of the self-signed Certificate uploaded in ACM"
  value       = aws_acm_certificate.self_signed_cert.arn
}

output "web_alb_id" {
  description = "The ID and ARN of the load balancer we created."
  value       = aws_lb.web_alb.id
}

output "web_alb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value       = aws_lb.web_alb.arn
}

output "web_alb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.web_alb.dns_name
}

output "web_alb_arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch."
  value       = aws_lb.web_alb.arn_suffix
}

output "web_alb_zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records."
  value       = aws_lb.web_alb.zone_id
}

output "http_tcp_listener_arn" {
  description = "The ARN of the TCP and HTTP load balancer listeners created."
  value       = aws_lb_listener.http_listener.arn
}

output "http_tcp_listener_id" {
  description = "The IDs of the TCP and HTTP load balancer listeners created."
  value       = aws_lb_listener.http_listener.id
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS load balancer listeners created."
  value       = aws_lb_listener.https_listener.arn
}

output "https_listener_id" {
  description = "The IDs of the load balancer listeners created."
  value       = aws_lb_listener.https_listener.id
}

output "target_group_arn" {
  description = "ARNs of the target groups. Useful for passing to your Auto Scaling group."
  value       = aws_lb_target_group.ec2_asg_tg.arn
}

output "target_group_arn_suffix" {
  description = "ARN suffixes of our target groups - can be used with CloudWatch."
  value       = aws_lb_target_group.ec2_asg_tg.arn_suffix
}

output "target_group_names" {
  description = "Name of the target group. Useful for passing to your CodeDeploy Deployment Group."
  value       = aws_lb_target_group.ec2_asg_tg.name
}

