resource "aws_instance" "ec2_generic_instance" {
  count                       = "${var.number_of_instances}"
  ami                         = "${var.aws_ami}"
  key_name                    = "${var.key_pair}"
  subnet_id                  = "${element(split(",", var.subnet_ids_aws), count.index)}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.public_ip}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.volume_size_root}"
    delete_on_termination = true
  }
  ebs_block_device {
    device_name = "/dev/sdh"
    volume_type = "gp2"
    volume_size = "${var.volume_size_mongodb}"
    delete_on_termination = true
  }

  vpc_security_group_ids = [
    "${var.security_groups}"
  ]

  tags {
    Name        = "aws_${var.environment}_${var.app_name}"
    Environment = "${var.environment}"
    Application = "${var.app_name}"
  }

}


resource "null_resource" "ansible_public" {
  count   = "${var.public_ip == "true" ? 1 : 0}"
  provisioner "local-exec" {
    command = "sleep 60 && cd ansible && chmod +x inventory/ec2.py && ansible-playbook -i inventory/ec2.py --private-key=${var.local_key} mongodb.yml --extra-vars 'tag_name_terraform=aws_${var.environment}_${var.app_name} host_ip1=${element(aws_instance.ec2_generic_instance.*.public_ip, 0)}  host_dns1=${element(split(",", var.cnames),0)} host_dns2=${element(split(",", var.cnames),1)} host_dns3=${element(split(",", var.cnames),2)}' "
  }
}

resource "null_resource" "ansible_private" {
  count   = "${var.public_ip == "false" ? 1 : 0}"
  provisioner "local-exec" {
    command = "sleep 60 && cd ansible && chmod +x inventory/ec2.py && ansible-playbook -i inventory/ec2.py --private-key=${var.local_key} mongodb.yml --extra-vars 'tag_name_terraform=aws_${var.environment}_${var.app_name} host_ip1=${element(aws_instance.ec2_generic_instance.*.private_ip, 0)}  host_dns1=${element(split(",", var.cnames),0)} host_dns2=${element(split(",", var.cnames),1)} host_dns3=${element(split(",", var.cnames),2)}' "
  }
}
