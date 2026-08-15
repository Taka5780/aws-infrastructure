resource "aws_route_table" "public_study_rt" {
  vpc_id = aws_vpc.study_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.study_igw.id
  }

  tags = {
    Name = "public-study-rt"
  }
}

# subntとroute tableの関連付け
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_study_subnet.id
  route_table_id = aws_route_table.public_study_rt.id
}
