
variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "allowed_accnt_ids" {
  type = list(string)
}

variable "name" {
  type = string
}

variable "env" {
  type = string
}