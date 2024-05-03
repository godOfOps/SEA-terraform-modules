resource "aws_route53_zone" "private" {
  name = var.route_53_hosted_zone_name

  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "alb-alias" {
  zone_id = aws_route53_zone.private.zone_id
  name    = var.elb_domain_name
  type    = "A"

  alias {
    name                   = aws_lb.web_alb.dns_name
    zone_id                = aws_lb.web_alb.zone_id
    evaluate_target_health = true
  }
}