terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0cb4e786f15603b0d"
  instance_type = "t2.micro"
  key_name = "iac-julio"
  # user_data = <<-EOF
  #                #!/bin/bash
  #                cd /home/ubuntu
  #                echo "<h1>Feito com terraform</h1>" > index.html
  #                nohup busybox httpd -f -p 8080 &
  #                EOF
  tags = {
    Name = "Teste aws"
  }
}