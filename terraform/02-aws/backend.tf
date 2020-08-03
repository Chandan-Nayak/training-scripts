
terraform {
  backend "s3" {
    bucket = "tf-demo-s3-state"
    key = "terraform.tfstate"
    region = "ap-south-1"
  }
}