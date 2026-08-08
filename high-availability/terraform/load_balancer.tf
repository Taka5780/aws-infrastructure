# Load Balancer
resource "aws_lb" "study_alb" {
  load_balancer_type = "application"
  name               = "study-alb"
  internal           = false
  ip_address_type    = "ipv4"
  subnets = [
    aws_subnet.public_study_subnet.id,
    aws_subnet.public_study_subnet_2.id
  ]
  security_groups = [aws_security_group.study_alb_sg.id]
}

resource "aws_lb_listener" "study_alb_http" {
  load_balancer_arn = aws_lb.study_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.study_tg_web.arn
  }
}
