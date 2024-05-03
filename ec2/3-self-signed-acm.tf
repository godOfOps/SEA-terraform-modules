resource "tls_private_key" "sea_private_key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "sea_self_signed" {
  private_key_pem = tls_private_key.sea_private_key.private_key_pem

  subject {
    common_name  = var.elb_domain_name
    organization = "SEA Terraform"
  }

  validity_period_hours = 8760 # 1year

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "self_signed_cert" {
  private_key      = tls_private_key.sea_private_key.private_key_pem
  certificate_body = tls_self_signed_cert.sea_self_signed.cert_pem
}