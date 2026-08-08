# public route table
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

# public route tableとpublic subnetの関連付け
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_study_subnet.id
  route_table_id = aws_route_table.public_study_rt.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_study_subnet_2.id
  route_table_id = aws_route_table.public_study_rt.id
}

# private route table
resource "aws_route_table" "private_study_rt" {
  vpc_id = aws_vpc.study_vpc.id

  tags = {
    Name = "private-study-rt"
  }
}

# private route tableとprivate subnetの関連付け
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_study_subnet.id
  route_table_id = aws_route_table.private_study_rt.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_study_subnet_2.id
  route_table_id = aws_route_table.private_study_rt.id
}
