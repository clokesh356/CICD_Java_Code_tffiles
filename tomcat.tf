#security group
resource "aws_security_group" "tomcat" {
  name        = "allow_tomcat"
  description = "Allow enduser"
  vpc_id      = "vpc-03a5eff0afffbbce9"

  ingress {
    description = "allow for alb"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh for admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "stage-tomcat-sg"
    Terraform = "true"
  }
}

resource "aws_instance" "tomcat" {
  ami           = "ami-0b89f7b3f054b957e"
  instance_type = "t2.micro"
  #   vpc_id =aws_vpc.vpc.id
  subnet_id              = "subnet-0dfd31840b6df123e"
  vpc_security_group_ids = [aws_security_group.tomcat.id]
  # key_name               = "testing"
  key_name  = aws_key_pair.demo.id
  

  tags = {
    Name = "stage-tomcat"
  }
}