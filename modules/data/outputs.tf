output "ami_id"  {value = "${data.aws_ami.ami.id}"}

output "zone_id" {value = "${data.aws_route53_zone.route53.zone_id}"}
