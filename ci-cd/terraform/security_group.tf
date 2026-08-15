data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}

resource "aws_security_group" "study_web_sg" {

  name        = "study-web-sg"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.study_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # 自身のipを動的に取得する
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "study-web-sg"
  }
}
