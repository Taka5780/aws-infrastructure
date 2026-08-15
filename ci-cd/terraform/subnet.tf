resource "aws_subnet" "public_study_subnet" {
  vpc_id                  = aws_vpc.study_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "public-study-subnet"
  }
}
