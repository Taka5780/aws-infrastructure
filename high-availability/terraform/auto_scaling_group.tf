# Autoscaling Group
resource "aws_autoscaling_group" "study_asg_web" {
  name = "study-asg-web"
  launch_template {
    id      = aws_launch_template.study_lt_web.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.private_study_subnet.id,
    aws_subnet.private_study_subnet_2.id
  ]

  target_group_arns = [
    aws_lb_target_group.study_tg_web.arn
  ]
  health_check_type = "ELB"
  desired_capacity  = 2
  min_size          = 2
  max_size          = 2
}
