resource "tls_private_key" "test_example_com" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "test_example_com" {
  private_key_pem = tls_private_key.test_example_com.private_key_pem

  subject {
    common_name  = "test.example.com"
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
  private_key      = tls_private_key.test_example_com.private_key_pem
  certificate_body = tls_self_signed_cert.test_example_com.cert_pem
}