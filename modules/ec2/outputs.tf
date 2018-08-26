output "private_ip" {
  value = "${join(",", aws_instance.ec2_generic_instance.*.private_ip)}"
}
