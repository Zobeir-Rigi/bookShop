resource "aws_instance" "ec2-auto-i-docker" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Created_By = "terraform"
  }
}