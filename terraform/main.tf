# It's a way to fetch the latest Ubuntu AMI automatically 
# Using data "aws_ami" resource to get the latest Ubuntu AMI
# Terraform can query AWS for the most recent Ubuntu image using this snippet:
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical official owner ID for Ubuntu

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# basic EC2 resource
# i named the instance ec2-auto-i-docker because i will be using it to run docker containers
resource "aws_instance" "ec2-auto-i-docker" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  # Add user_data script to EC2 instance for automated Docker installation and container startup

 user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              docker login -u ${var.dockerhub_username} -p ${var.dockerhub_token}
              docker pull ${var.dockerhub_username}/backend-server-ec2:latest
              docker run -d -p 80:8800 ${var.dockerhub_username}/backend-server-ec2:latest
              EOF


  tags = {
    Created_By = "terraform"
  }
}

