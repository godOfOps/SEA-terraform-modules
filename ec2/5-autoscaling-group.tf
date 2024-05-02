resource "aws_autoscaling_group" "ec2_asg" {
  name                = "${var.env}-webapp-asg"
  desired_capacity    = var.scaling_config["desired_capacity"]
  max_size            = var.scaling_config["max_size"]
  min_size            = var.scaling_config["min_size"]
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.ec2_asg_tg.arn]
  health_check_type   = "ELB"
  launch_template {
    id      = aws_launch_template.private_ec2_lt.id
    version = "$Latest"
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
    #A refresh is started when any of the following Auto Scaling Group properties change: launch_configuration, launch_template, mixed_instances_policy.
    #Additional properties can be specified in the triggers property of instance_refresh.
  }
  tag {
    key                 = "Environment"
    value               = var.env
    propagate_at_launch = true
  }
}


###### Target Tracking Scaling Policies ######
# Scaling Policy-1: Based on CPU Utilization
resource "aws_autoscaling_policy" "avg_cpu_policy" {
  name                   = "avg-cpu-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.id
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.average_cpu_util
  }
}

# Scaling Policy-2: Based on ALB Target Requests
resource "aws_autoscaling_policy" "alb_target_requests" {
  name                   = "alb-target-requests"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.id
  # Number of requests > 10 completed per target in an Application Load Balancer target group.
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${aws_lb.web_alb.arn_suffix}/${aws_lb_target_group.ec2_asg_tg.arn_suffix}"
    }
    target_value = var.request_count_per_target
  }
}
