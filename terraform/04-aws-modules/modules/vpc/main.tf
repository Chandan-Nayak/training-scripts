

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = format("%s-%s-vpc", var.vpc_name, var.env)
    Terraform = "yes"
    Env = var.env
  }
}

resource "aws_subnet" "this" {
  cidr_block = var.subnet_cidr
  vpc_id = aws_vpc.this.id

  tags = {
    Name = format("%s-%s-subnet", var.subnet_name, var.env)
    Terraform = "yes"
    Env = var.env
  }
}