# public subnet
resource "aws_subnet" "public_study_subnet" {
  vpc_id                  = aws_vpc.study_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "public-study-subnet"
  }
}

# private subnet
resource "aws_subnet" "private_study_subnet" {
  vpc_id            = aws_vpc.study_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "private-study-subnet"
  }
}

# public subnet
resource "aws_subnet" "public_study_subnet_2" {
  vpc_id                  = aws_vpc.study_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1d"

  tags = {
    Name = "public-study-subnet-2"
  }
}

# private  subnet
resource "aws_subnet" "private_study_subnet_2" {
  vpc_id            = aws_vpc.study_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "private-study-subnet-2"
  }
}
