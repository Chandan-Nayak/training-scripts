resource "aws_security_group" "this" {
  name = "terraform-test-sg"
  vpc_id = var.vpc_id


  tags = {
    Name = format("%s-%s-sg", var.name, var.env)
    Terraform = "yes"
    Env = var.env
  }
}