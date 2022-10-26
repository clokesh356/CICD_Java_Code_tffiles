resource "aws_security_group" "cicd" {
  name        = "allow cicd http"
  description = "Allow  cicd enduser"
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
    Name      = "stage-cicd-sg"
    Terraform = "true"
  }
}

resource "aws_instance" "cicd" {
  ami           = "ami-0b89f7b3f054b957e"
  instance_type = "c5.2xlarge"
  #   vpc_id =aws_vpc.vpc.id
  subnet_id              = "subnet-0dfd31840b6df123e"
  vpc_security_group_ids = [aws_security_group.cicd.id]
  key_name               = aws_key_pair.demo.id
  iam_instance_profile   = aws_iam_instance_profile.artifactory.name
  # key_name = "testing"
  user_data = <<-EOF
              #!/bin/bash
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum update -y
amazon-linux-extras install java-openjdk11
yum install jenkins -y
systemctl start jenkins
systemctl enable jenkins
# cd /opt
# wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
# tar -xzvf apache-maven-3.8.6-bin.tar.gz
# mv apache-maven-3.8.6 maven38
# # mv target/sparkjava-hello-world-1.0.war target/sparkjava-hello-world-$BUILD_NUMBER.war
# # aws s3 cp target/sparkjava-hello-world-$BUILD_NUMBER.war s3://java-maven-0projects-cicd/
# aws s3 cp s3://java-maven-0projects-cicd/sparkjava-hello-world-$PKG.war .
# scp -r sparkjava-hello-world-$PKG.war root@172.31.12.104:/opt/tomcat9/webapps/
              EOF

  tags = {
    Name = "stage-cicd"
  }
  # lifecycle {
  #  create_before_destroy = true
  # }
}

