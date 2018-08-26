variable "protocol" {
  default = "tcp"
}

variable "from_port" {
  default = "0"
}

variable "to_port" {
  default = "65535"
}

variable "range" {
  default = "0.0.0.0/0"
}

variable "vpc_id" {
  default = "vpc-a7aaa3de"
}

variable "public_ip" {
  default = "true"
}

variable "app_name" {
  description = "My case add in circleci env"
  default = ""
}

variable "subnet_id" {
  default = "subnet-3a14fb71,subnet-60be6504,subnet-3a14fb71"
}

variable "key_pair" {
  default = "wilton"
}

variable "instance_type" {
  default = "t2.small"
}

variable "environment" {
  description = "My case add in circleci env"
  default = ""
}


variable "number_of_instances" {
  default = 3
}


variable "volume_size_root" {
  default = "8"
}

variable "volume_size_mongodb" {
  default = "30"
}

variable "local_key" {
  description = "My case add in circleci env"
  default = ""
}

variable "domain" {
  default = "rivendel-auth.com.br"
}
