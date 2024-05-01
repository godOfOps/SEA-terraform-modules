resource "aws_ec2_instance_connect_endpoint" "ec2-ep" {
  subnet_id          = var.subnet_ids[0]
  security_group_ids = [aws_security_group.ec2_sg.id]
}