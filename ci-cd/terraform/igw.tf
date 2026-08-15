resource "aws_internet_gateway" "study_igw" {
  vpc_id = aws_vpc.study_vpc.id

  tags = {
    Name = "study-igw"
  }
}
