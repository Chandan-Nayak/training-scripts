

provider "aws" {
  region = var.region
  version = "~> 2.0"
  allowed_account_ids = var.allowed_accnt_ids
}

module "aws-vpc" {
  source = "../modules/vpc"
  env = "dev"
  subnet_name = "demo"
  vpc_name = "demo"
}