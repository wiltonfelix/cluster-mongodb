resource "aws_security_group" "security_group" {
  name   = "aws-${var.environment}-${var.app_name}"
  vpc_id = "${var.vpc_id}"
  revoke_rules_on_delete = "true"

  ingress {
    protocol    = "${var.protocol}"
    from_port   = "${var.from_port}"
    to_port     = "${var.to_port}"
    cidr_blocks = ["${split(",", var.range)}"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
