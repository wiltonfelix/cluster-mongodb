resource "aws_route53_record" "mongo_route" {
  count   = "${var.number_of_instances}"
  zone_id = "${var.zone_id}"
  name    = "${var.app_name}-${var.environment}-${(count.index + 1)}"
  type    = "A"
  ttl     = "300"
  records = ["${element(split(",", var.ips), count.index)}"]
}
