resource "aws_lb" "alb" {
  name               = "ECS-Django-123321456789"
  security_groups    = [aws_security_group.sg_alb.id]
 # subnets            = [for subnet in aws_subnet.public : subnet.id]
 # A forma acima permite que coloquemos todas as subnets publicas desejadas na variável, porém,
 #o módulo vpc fornece uma função que retorna todas as subnets publicas criadas por nós
  subnets            = module.vpc.public_subnets
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8000"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target.arn
  }
}

resource "aws_lb_target_group" "target" {
  name        = "tf-example-lb-tg"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}

output "IP" {
  value = aws_lb.alb.dns_name
}