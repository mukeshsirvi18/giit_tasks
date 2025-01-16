resource "aws_instance" "create_instance" {
    ami           = var.instance_info.ami
    instance_type = var.instance_info.instance_type
    subnet_id     = var.subnet_id
    key_name      = var.instance_info.key_name
    vpc_security_group_ids = var.vpc_security_group_ids
    count = var.instance_info.count
    associate_public_ip_address = true
    tags = {
        Name = "${var.instance_info.name}${count.index + 1}"
        Env = "${var.instance_info.env}"
    }

    user_data = var.instance_info.user_data
}
