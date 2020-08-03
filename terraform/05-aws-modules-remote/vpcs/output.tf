
output "vpc_id" {
  value = module.aws-vpc.vpc_id
}

output "subnet_id" {
  value = module.aws-vpc.subnet_id
}

output "vpc_tags" {
  value = module.aws-vpc.vpc_tags
}