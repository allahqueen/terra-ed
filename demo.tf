resource "aws_vpc" "demovpc" {
    cidr_block = var.demovpccidr
    tags = "vpc1"
  
}
resource "aws_subnet" "subnet1" {
    cidr_block = var.subnet1cidr
    availability_zone = var.AZ1
    tags = {
      "Name" = "my-subnet"
    }
  
}
resource "aws_iam_role" "EC2-s3-role" {
  name = "EC2-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "myrole"
  }
}
resource "aws_iam_policy" "ec2-policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"
  role = aws_iam_role.EC2-s3-role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject*",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_instance_profile" "profile" {
    name = "ec2_s3_role"
    role = [aws_iam_role.EC2-s3-role]
  
}
resource "aws_instance" "testinstance" {
    ami = "ami-0d9858aa3c6322f73"
    instance_type = "t2.micro"
    tags = {
      "Name" = "test-instance"
      associate_public_ip_address = true
    }
  
}

  
