
variable "AWS_REGION" {
	default = "eu-west-1"
}

# If you are using diffrent region (other than us-east-1) please find ubuntu 18.04 ami for that region and change here.
variable "ami_id" {
    type = string
    default = "ami-0694d931cee176e7d"
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "private_subnets" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "master_node_count" {
    type = number
    default = 1
}

variable "worker_node_count" {
    type = number
    default = 2
}

variable "ssh_user" {
    type = string
    default = "ubuntu"
}

variable "master_instance_type" {
    type = string
    default = "t3.small"
}

variable "worker_instance_type" {
    type = string
    default = "t3.micro"
}