output "cnames" {value = "${join(",", aws_route53_record.mongo_route.*.fqdn)}"}
