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

resource "aws_instance" "mi_servidor" {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
}
