provider "aws" {
  region = "ap-south-1"
}

# Generate a random suffix to avoid naming collisions
resource "random_id" "suffix" {
  byte_length = 4
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Create a new Internet Gateway for default VPC
resource "aws_internet_gateway" "default" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "motivation-igw"
  }
}

# Create a subnet in ap-south-1a
resource "aws_subnet" "public_1a" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.1.0/24" 
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "motivation-subnet-1a"
  }
}

# Route Table for the VPC with default route to IGW
resource "aws_route_table" "public" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "motivation-public-rt"
  }
}

# Associate Route Table with the subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}

# Security Group allowing SSH and ports 80, 5000, 8080
resource "aws_security_group" "motivation_sg" {
  name        = "motivation-web-sg-${random_id.suffix.hex}"
  description = "Allow SSH and web traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = "motivation-sg-${random_id.suffix.hex}"
  }
}

# EC2 Instance in the public subnet with the security group
resource "aws_instance" "motivation_app" {
  ami                    = "ami-0f5ee92e2d63afc18"  # Ubuntu 22.04 LTS (ap-south-1)
  instance_type          = "t3.medium"
  key_name               = "lab3"
  subnet_id              = aws_subnet.public_1a.id
  user_data              = file("ec2_setup.sh")
  vpc_security_group_ids = [aws_security_group.motivation_sg.id]

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "MotivationWebApp"
  }
}
