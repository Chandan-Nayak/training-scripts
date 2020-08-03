
provider "aws" {
  region = var.region
  version = "~> 3.0"
  allowed_account_ids = var.allowed_accnt_ids
}

data "aws_caller_identity" "this" {}


resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = format("%s-%s-vpc", var.name, var.env)
    Terraform = "yes"
    Env = var.env
  }
}

resource "aws_subnet" "this" {
  cidr_block = var.subnet_cidr
  vpc_id = aws_vpc.this.id

  tags = {
    Name = format("%s-%s-subnet", var.name, var.env)
    Terraform = "yes"
    Env = var.env
  }
}

resource "aws_security_group" "this" {
  name = "terraform-test-sg"
  vpc_id = aws_vpc.this.id
  tags = {
    Name = format("%s-%s-sg", var.name, var.env)
    Terraform = "yes"
    Env = var.env
  }
}