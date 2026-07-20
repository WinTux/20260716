terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.mi_region_aws
}

locals {
  Environment = "Dev"
}

#data "aws_subnet" "default" {
#  default_for_az = true # Para no poner el ID de la subnet
#}

resource "aws_instance" "mi_servidor" {
  for_each = var.nombres_servicios
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  subnet_id = module.vpc.public_subnets[0]  #"subnet-0ec43cfc20f6562ea" # data.aws_subnet.default.id
  vpc_security_group_ids = [module.terraform-sg.security_group_id]
  associate_public_ip_address = true
  tags = {
    Name = "ServidorTerraform-${each.key}"
    Environment = local.Environment
    Owner = "Pepe"
  }
}

resource "aws_cloudwatch_log_group" "grupo_log_ec2" {
  for_each = var.nombres_servicios
  tags = {
    Environment = "Prueba"
    Servicio = each.key
  }
  lifecycle {
    create_before_destroy = true
  }
}
