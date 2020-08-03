

provider "aws" {
  region = var.region
  version = "~> 3.0"
  allowed_account_ids = var.allowed_accnt_ids
}

module "aws-vpc" {
  source = "./modules/vpc"
  env = "dev"
  subnet_name = "demo"
  vpc_name = "demo"
}


module "aws-sg" {
  source = "./modules/sg"
  env = "dev"
  name = "demo"
  vpc_id = module.aws-vpc.vpc_id
}