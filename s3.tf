resource "aws_s3_bucket" "artifactory" {
  bucket = "artifactory-cicd-labs-devops"
  tags = {
    Name = "artifactory-cicd-labs-demo"
  }
}