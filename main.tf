provider "aws" {
    region = "us-east-1"
    access_key = "AWP6LK"
    secret_key = "gRNWg"
  
}

resource "aws_security_group" "sg" {
  name        = "wld-all-ports-tf-${var.IDENTIFIER}"
  description = "Allow all ports, just for testing"
  vpc_id      = var.VPC_ID

  ingress {
    description = "Allowing all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "allow-all-${var.IDENTIFIER}"
  }

}

resource "aws_instance" "default" {
  ami = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  key_name = "dummy"
  subnet_id = var.SUBNET_ID

  vpc_security_group_ids = ["${aws_security_group.sg.id}"]

  tags = {
    "Name" = "wld-tf-${var.IDENTIFIER}"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
	 volume_type = "gp2"
	 volume_size = "10"
	 delete_on_termination = "true"
  }

  
}

output "instance_ips" {
  #value = ["${aws_instance.default.public_ip}"]
  value = "PublicIP: ${aws_instance.default.public_ip} , PrivateIP: ${aws_instance.default.private_ip}"

sajjad
