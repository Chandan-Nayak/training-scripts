
output "sg_id" {
  value = module.aws-sg.sg_id
}

output "all_remote_vars" {
  value = data.terraform_remote_state.remote-vpc.outputs
}