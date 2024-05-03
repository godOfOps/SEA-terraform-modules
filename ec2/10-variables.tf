variable "env" {
  description = "Environment name."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "ingress_ports_elb" {
  description = "Allow Inbound Access to following ports"
  type        = list(number)
  default     = [80, 443]
}

variable "ingress_ports_ec2" {
  description = "Allow Inbound Access to following ports"
  type        = list(number)
  default     = [80, 8080]
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type        = string
  default     = "sea-kp"
}

variable "volume_size" {
  description = "Volume Size of secondary EBS Volume in GB"
  type        = number
  default     = 10
}

variable "route_53_hosted_zone_name" {
  description = "Route 53 hosted Zone name"
  type        = string
  default     = "example.com"
}

variable "elb_domain_name" {
  description = "Domain name alias for Load Balancer"
  type        = string
  default     = "test.example.com"
}

variable "scaling_config" {
  description = "Min, Max, Desired for ASG"
  type        = map(number)
  default = {
    min_size         = 2
    max_size         = 5
    desired_capacity = 2
  }
}

variable "average_cpu_util" {
  description = "Average CPU Utilization to trigger ASG Scaling action"
  type        = number
  default     = 70.0
}
variable "request_count_per_target" {
  description = "Average Request Count Per Target to trigger ASG Scaling action"
  type        = number
  default     = 10.0
}

variable "notification_email_ids" {
  description = "List of emails to send Application Health Issue Notifications"
  type        = list(string)
}