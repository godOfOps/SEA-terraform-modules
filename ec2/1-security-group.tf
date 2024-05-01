# Security group
resource "aws_security_group" "elb_sg" {
  name   = "${var.env}-elb-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports_elb
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      description      = "Allow Traffic from Internet both IPv4 and V6"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "ec2_sg" {
  name   = "${var.env}-ec2-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" { #Allowing from both 80 and 8080 based on choice of webserver later
    for_each = var.ingress_ports_ec2
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      description     = "Allow Traffic from Load Balancer"
      security_groups = [aws_security_group.elb_sg.id]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow SSH with Ec2 Instance connect Endpoint"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}