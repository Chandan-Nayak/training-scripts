variable "vpc_cidr" {
  type = string
  default = "172.31.0.0/16"
}

variable "subnet_cidr" {
  type = string
  default = "172.31.0.0/20"
}

variable "vpc_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "env" {
  type = string
}