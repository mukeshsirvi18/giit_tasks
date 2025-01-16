resource "aws_security_group" "sub_sg" {
  name        = var.sub_sg.name
  description = var.sub_sg.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = toset(range(length(var.sub_sg.req_ports)))
    content {
      from_port   = var.sub_sg.req_ports[ingress.key]
      to_port     = var.sub_sg.req_ports[ingress.key]
      protocol    = var.sub_sg.req_protocol[ingress.key]
      cidr_blocks = [var.sub_sg.req_cidr[ingress.key]]
      #ipv6_cidr_blocks = ["::/0"]
    }
  }
 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.sub_sg.name
  }
}



