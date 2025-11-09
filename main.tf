
variable "vpc_id" {
    default = "vpc-0d7addae06ac555fc"    # Your VPC Default ID
}

variable "key_name" {
    default = "sshkey1"               # Your AWS SSH Key
}

resource "aws_instance" "ecommerce" {
  ami           = "ami-0ecb62995f68bb549"   # Ubuntu 24.04 AMI ID
  instance_type = "t3a.large"
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  associate_public_ip_address = true
  
  root_block_device {
    volume_size = 30   
    volume_type = "gp3"
  }

  tags = {
    Name = "ecommerce"
    ambiente = "bootcamp"
  }
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic on EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}
