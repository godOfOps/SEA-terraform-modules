data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "private_ec2_lt" {
  name          = "${var.env}-private_ec2_launch_template"
  image_id      = data.aws_ami.al2023.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  #key_name               = var.instance_keypair
  user_data = filebase64("${path.module}/web-app-setup.sh") #needs to be test where it take it from
  #ebs_optimized          = true # Might not work with t2.micro
  #default_version = 1
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda" #Modify Root volume to enable encryption
    ebs {
      encrypted = true
    }
  }
  block_device_mappings {
    device_name = "/dev/sdb"
    ebs {
      volume_size           = var.volume_size
      delete_on_termination = true
      volume_type           = "gp3"
      encrypted             = true
    }
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.env}-instance"
    }
  }
}
