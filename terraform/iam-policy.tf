resource "aws_iam_policy" "ec2_access_policy" {
  name        = "ec2-access-policy"
  description = "Allows EC2 actions needed for Terraform deployment"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ec2:DescribeImages",
        "ec2:RunInstances",
        "ec2:DescribeInstances",
        "ec2:StartInstances",
        "ec2:StopInstances"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_user_policy_attachment" "attach_ec2_access" {
  user       = "dynamoDbUser"
  policy_arn = aws_iam_policy.ec2_access_policy.arn
}
