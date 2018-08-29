provider "aws" {
}

terraform {
  backend "s3" {
    bucket = "infra-as-code-git"
    key    = "data/mongodb"
    region = "us-east-1"
  }
}

module "security_group" {
  source      = "../modules/security_group"
  environment = "${var.environment}"
  app_name    = "${var.app_name}"
  vpc_id      = "${var.vpc_id}"
  protocol    = "${var.protocol}"
  from_port   = "${var.from_port}"
  to_port     = "${var.to_port}"
  range       = "${var.range}"
}

module "data_source" {
  source              = "../modules/data"
  domain              = "${var.domain}"
}

module "ec2" {
  source               = "../modules/ec2"
  subnet_ids_aws       = "${var.subnet_ids_aws}"
  app_name             = "${var.app_name}"
  key_pair             = "${var.key_pair}"
  instance_type        = "${var.instance_type}"
  environment          = "${var.environment}"
  aws_ami              = "${module.data_source.ami_id}"
  number_of_instances  = "${var.number_of_instances}"
  security_groups      = "${module.security_group.security_group_id}"
  volume_size_root     = "${var.volume_size_root}"
  local_key            = "${var.local_key}"
  volume_size_mongodb  = "${var.volume_size_mongodb}"
  cnames               = "${module.route53.cnames}"
  public_ip            = "${var.public_ip}"
}

module "route53" {
  source               = "../modules/route53"
  zone_id              = "${module.data_source.zone_id}"
  ips                  = "${module.ec2.private_ip}"
  environment          = "${var.environment}"
  app_name             = "${var.app_name}"
  number_of_instances  = "${var.number_of_instances}"
}
