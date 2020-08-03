

provider "aws" {
  region = var.region
  version = "~> 3.0"
  allowed_account_ids = var.allowed_accnt_ids
}

data "terraform_remote_state" "remote-vpc" {
  backend = "s3"
  config = {
    bucket = "tf-demo-s3-state"
    key = "remote/vpcs/terraform.tfstate"
    region = "ap-south-1"
  }
}

module "aws-sg" {
  source = "../modules/sg"
  env = "dev"
  name = "my-sg"
  vpc_id = data.terraform_remote_state.remote-vpc.outputs.vpc_id
}

