output "security_group_id" {value = "${join(",", aws_security_group.security_group.*.id)}"}
