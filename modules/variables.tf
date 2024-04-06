variable "region" {
  default = "us-east-1"
}
variable "access_key" {}
variable "secret_key" {}

# Varibles for VPC

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "myVPC"
}

variable "subnets_cidr_public" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "azs_public" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1c"]
}

# Variables for EC2

variable "instance_ami" {
  default = "ami-096fda3c22c1c990a"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "keyname" {
  default = "webserver"
}