resource "aws_security_group" "myajay_app_sg" {
  name        = "myajay-app-sg"
  description = "sg for myajay app"
  vpc_id      = "vpc-084a10f473fb0a8bb"
}

resource "aws_security_group_rule" "ssh_rule" {
  type              = "ingress"
  description       = "ssh access"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.myajay_app_sg.id
}

resource "aws_security_group_rule" "http_rule" {
  type              = "ingress"
  description       = "http access"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.myajay_app_sg.id
}


resource "aws_security_group_rule" "outbound_rule" {
  type              = "egress"
  description       = "outbound access"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.myajay_app_sg.id
}