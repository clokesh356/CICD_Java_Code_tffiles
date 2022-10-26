#role
resource "aws_iam_role" "artifactory" {
  name = "artifactory-cicd"

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
    tag-key = "artifactory-cicd "
  }
}



#policy
resource "aws_iam_policy" "artifactory" {
  name        = "artifactory_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}




#attach policy to role
resource "aws_iam_policy_attachment" "artifactory" {
  name       = "test-attachment"
  roles      = [aws_iam_role.artifactory.name]
  policy_arn = aws_iam_policy.artifactory.arn
}

#attach role to ec2
resource "aws_iam_instance_profile" "artifactory" {
  name = "artifactory_profile"
  role = aws_iam_role.artifactory.name
}