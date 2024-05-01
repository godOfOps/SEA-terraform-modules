resource "aws_lb" "web_alb" {
  name               = "${var.env}-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = var.subnet_ids

  tags = {
    Name        = "${var.env}-web-alb"
    Environment = var.env
  }
}

resource "aws_lb_target_group" "ec2_asg_tg" {
  name     = "${var.env}-ec2-asg-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    interval            = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
    path                = "/index.html"
    port                = "traffic-port"
    timeout             = 15
    protocol            = "HTTP"
    matcher             = "200-399"
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.self_signed_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_asg_tg.arn
  }
}