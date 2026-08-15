resource "aws_instance" "study_web" {
  ami                    = "ami-0ba6f6ad9f47de1c2"
  instance_type          = "t2.nano"
  key_name               = var.key_name
  subnet_id              = aws_subnet.public_study_subnet.id
  vpc_security_group_ids = [aws_security_group.study_web_sg.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "study-web"
  }
}
