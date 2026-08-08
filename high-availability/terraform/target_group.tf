# ALB Target Group
resource "aws_lb_target_group" "study_tg_web" {
  target_type      = "instance"
  name             = "study-tg-web"
  protocol         = "HTTP"
  port             = 80
  ip_address_type  = "ipv4"
  vpc_id           = aws_vpc.study_vpc.id
  protocol_version = "HTTP1"

  health_check {
    path     = "/"
    protocol = "HTTP"
  }

  tags = {
    Name = "study-tg-web"
  }
}
