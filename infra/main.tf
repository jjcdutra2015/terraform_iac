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
  region  = var.regiao_aws
}

resource "aws_launch_template" "maquina" {
  image_id      = "ami-0cb4e786f15603b0d"
  instance_type = var.instancia
  key_name      = var.chave
  tags = {
    Name = "Terraform Ansible Pytohn"
  }
  security_group_names = [var.grupo_seguranca]
}

resource "aws_key_pair" "chaveSSH" {
  key_name   = var.chave
  public_key = file("${var.chave}.pub")
}

resource "aws_autoscaling_group" "grupo" {
  availability_zones = ["${var.regiao_aws}a"]
  name               = var.nomeGrupo
  max_size           = var.maximo
  min_size           = var.minimo
  launch_template {
    id      = aws_launch_template.maquina.id
    version = "$Latest"
  }
}
