resource "aws_route53_zone" "private" {
  name = "example.com"

  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "alb-alias" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "test.example.com"
  type    = "A"

  alias {
    name                   = aws_lb.web_alb.dns_name
    zone_id                = aws_lb.web_alb.zone_id
    evaluate_target_health = true
  }
}