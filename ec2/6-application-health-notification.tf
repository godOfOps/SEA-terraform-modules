# Target Group Health Notification
## SNS - Topic
resource "aws_sns_topic" "aws_tg_health_sns" {
  name = "aws-tg-health-sns"
}

## SNS - Subscription
resource "aws_sns_topic_subscription" "myasg_sns_topic_subscription" {
  topic_arn = aws_sns_topic.aws_tg_health_sns.arn
  protocol  = "email"
  endpoint  = "ankitkrsingh13@gmail.com"
}

resource "aws_cloudwatch_metric_alarm" "alb_healthy_hosts" {
  alarm_name          = "Web-Application-Health"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 0
  alarm_description   = "Number of unhealthy Instances in Target Group"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.aws_tg_health_sns.arn]
  ok_actions          = [aws_sns_topic.aws_tg_health_sns.arn]
  dimensions = {
    TargetGroup  = aws_lb_target_group.ec2_asg_tg.arn_suffix
    LoadBalancer = aws_lb.web_alb.arn_suffix
  }
}