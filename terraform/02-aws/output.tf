
output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_id" {
  value = aws_subnet.this.id
}

output "vpc_tags" {
  value = aws_vpc.this.tags
}

output "sg_id" {
  value = aws_security_group.this.id
}

output "account_id" {
  value = data.aws_caller_identity.this.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.this.arn
  sensitive   = true
}