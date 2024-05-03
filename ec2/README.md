# EC2 Module

This module creates the following resources:

* ELB Security Group to allow inbound access from Internet to Load Balancer
* EC2 Security Group to allow HTTP inbound access from ALB and SSH Access from EC2 instance connect endpoint
* Launch Template(instead of Launch Configuration) to launch EC2 Instances with dynamically fetched latest Amazon Linux 2023 AMI and with a Secondary Volume attached with both root and secondary volume encrypted
* User-data for EC2 to dynamically mount the secondary volume to EC2 and setup Apache HTTPD Web-server with a sample web app
* Self-signed Certificate uploaded to AWS Certificate Manager for ELB HTTPS Endpoint
* Route 53 Private Hosted Zone with Alias routing to ALB with Terget Health Evaluation
* Application Load Balancer in Public Subnet with HTTP and HTTPS Listener with HTTP to HTTPS Redirection
* ALB Target Group with Auto-scaling Group EC2 targets with Health Check enabled
* Auto Scaling Group using the Launch Template with Target Tracking Scaling Policy for Average CPU Util and Average Request per target
* Cloudwatch Alarm monitoring ALB Target Group Health and Send Email Notification via SNS
* EC2 Instance Connect Endpoint to SSH to EC2 Webservers without using Key-pair

**Inputs Required:**

Input Name | Sample Value | Description |
--- | --- | --- |
env | "10.0.0.0/16" | VPC CIDR |
vpc_id | "vpc-0cbcf9dc884a5d2cb" | VPC ID |
private_subnet_ids | [ "subnet-08adb5ca4fb972fea", "subnet-035c913f068824be1"] | Private Subnet IDs |
public_subnet_ids | [ "subnet-0bf221338db395a57", "subnet-0e08ef7bc327618aa"] | Public Subnet IDs |
ingress_ports_elb | [80, 443] | Allow Inbound Access to ELB |
ingress_ports_ec2 | [80] | Allow Inbound Access from ELB to EC2 |
instance_type | "t2.micro" | EC2 Instance Type |
instance_keypair | "sea-kp" | Key Pair for Connecting to Ec2 |
volume_size | 10 | Secondary Volume Size in GB |
scaling_config | { <br>  min_size = 2<br>  max_size = 5<br>  desired_capacity = 2<br>} | Min, Max, Desired for ASG |
average_cpu_util | 70.0 | Average CPU Utilization to trigger ASG Scaling action |
request_count_per_target | 10.0 | Average Request Count Per Target to trigger ASG Scaling action |
notification_email_ids | ["test@example.com"] | List of emails to send Application Health Issue Notifications |
route_53_hosted_zone_name | "example.com" | Route 53 hosted Zone name |
elb_domain_name | "test.example.com" | Domain name alias for Load Balancer |

**Outputs:**
Output | Sample Value | Description |
--- | --- | --- |
autoscaling_group_arn | "arn:aws:autoscaling:us-west-2:810900642966:autoScalingGroup:c0527efe-9aa0-4c31-b5f4-3c5d6943cdda:autoScalingGroupName/dev-webapp-asg" | Autoscaling Group ARN |
autoscaling_group_id | "dev-webapp-asg" | Autoscaling Group ID |
autoscaling_group_name | "dev-webapp-asg" | Autoscaling Group Name |
certificate_arn | "arn:aws:acm:us-west-2:810900642966:certificate/5da39c5a-7f61-4ca6-be85-d822f5567e4e" | Certificate arn of the self-signed Certificate uploaded in ACM |
ec2_sg_id | "sg-096d9d409736ccd58" | Security Group ID for EC2 |
elb_sg_id | "sg-0b2fc33748ffdaee8" | Security Group ID for ELB |
http_tcp_listener_arn | "arn:aws:elasticloadbalancing:us-west-2:810900642966:listener/app/dev-web-alb/5959ddfcda37a48a/ae46e892a255d941" | The ARN of the TCP and HTTP load balancer listeners created |
http_tcp_listener_id | "arn:aws:elasticloadbalancing:us-west-2:810900642966:listener/app/dev-web-alb/5959ddfcda37a48a/ae46e892a255d941" | The ID of the TCP and HTTP load balancer listeners created |
https_listener_arn | "arn:aws:elasticloadbalancing:us-west-2:810900642966:listener/app/dev-web-alb/5959ddfcda37a48a/a137dc97ce0d389b" | The ARN of the HTTPS load balancer listeners created |
https_listener_id | "arn:aws:elasticloadbalancing:us-west-2:810900642966:listener/app/dev-web-alb/5959ddfcda37a48a/a137dc97ce0d389b" | The ID of the HTTPS load balancer listeners created |
launch_template_id | "lt-014a10f45c8511d22" | Launch Template ID |
launch_template_latest_version | 3 | Launch Template Latest Version |
target_group_arn | "arn:aws:elasticloadbalancing:us-west-2:810900642966:targetgroup/dev-ec2-asg-tg/f174ac89081b2f24" | Target Group ARN |
target_group_arn_suffix | "targetgroup/dev-ec2-asg-tg/f174ac89081b2f24" | ARN suffixes of our target groups - can be used with CloudWatch |
target_group_names | "dev-ec2-asg-tg" | Name of the target group. Useful for passing to your CodeDeploy Deployment Group |
web_alb_arn | "arn:aws:elasticloadbalancing:us-west-2:810900642966:loadbalancer/app/dev-web-alb/5959ddfcda37a48a" | The ARN of the load balancer created |
web_alb_arn_suffix | "app/dev-web-alb/5959ddfcda37a48a" | ARN suffix of our load balancer - can be used with CloudWatch |
web_alb_dns_name | "dev-web-alb-88563410.us-west-2.elb.amazonaws.com" | The DNS name of the load balancer |
web_alb_id | "arn:aws:elasticloadbalancing:us-west-2:810900642966:loadbalancer/app/dev-web-alb/5959ddfcda37a48a" | The ID of the load balancer created |
web_alb_zone_id | "Z1H1FL5HABSF5" | The zone_id of the load balancer to assist with creating DNS records |