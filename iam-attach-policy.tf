resource "aws_iam_user_policy_attachment" "attach_ec2_read_only" {
  user       = "dynamoDbUser"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
