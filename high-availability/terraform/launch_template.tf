# Launch Template
resource "aws_launch_template" "study_lt_web" {
  name          = "study-lt-web"
  description   = "Study Web Server"
  image_id      = "ami-0ba6f6ad9f47de1c2"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.study_web_sg.id]

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      volume_type = "gp3"
      iops        = 3000
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.study_ec2_ssm_profile.name
  }

  user_data = base64encode(
    <<-EOF
      #!/bin/bash

      dnf update -y
      dnf install -y nginx
      systemctl enable nginx
      systemctl start nginx
    EOF
  )
}
