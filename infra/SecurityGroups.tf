resource "aws_security_group" "sg_alb" {
  name        = "allow_ecs"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ingress_alb" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp" 
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "egress_alb" {
  type              = "egress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "-1" #aceita todos protocolos
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.sg_alb.id
}

#security group privado
resource "aws_security_group" "sg_privado" {
  name        = "privado_ecs"
  vpc_id = module.vpc.vpc_id
}

#estas requisições virão do Load Balancer
resource "aws_security_group_rule" "ingress_private" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" 
  source_security_group_id =  aws_security_group.sg_alb.id
  security_group_id = aws_security_group.sg_privado.id
}

resource "aws_security_group_rule" "egress_private" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" #aceita todos protocolos
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.sg_privado.id
}