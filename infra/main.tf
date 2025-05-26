provider "aws" {
  region = "ap-south-1"
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get existing Internet Gateway attached to default VPC
data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
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

# Route Table for the VPC with default route to existing IGW
resource "aws_route_table" "public" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default.id
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

# Security Group allowing SSH and port 5000
resource "aws_security_group" "motivation_sg" {
  name        = "motivation-web-sg"
  description = "Allow SSH and web traffic"

  ingress {
    from_port   = 22      #SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80      #http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000    #custom web port
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0       #allow all outbound
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance in the public subnet with the security group
resource "aws_instance" "motivation_app" {
  ami                    = "ami-0f5ee92e2d63afc18"  # Ubuntu Server 22.04 LTS (ap-south-1)
  instance_type          = "t2.micro"
  key_name               = "lab3"
  subnet_id              = aws_subnet.public_1a.id
  user_data              = file("ec2_setup.sh")
  vpc_security_group_ids = [aws_security_group.motivation_sg.id]

  tags = {
    Name = "MotivationWebApp"
  }
}
