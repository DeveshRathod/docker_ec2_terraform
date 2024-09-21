resource "aws_instance" "app_mumbai" {
  ami                = "ami-08718895af4dfa033"
  instance_type      = var.instance_type
  key_name           = var.key_pair
  availability_zone  = "ap-south-1a"
  vpc_security_group_ids = [var.mumbai_security_group_id]
  subnet_id = "subnet-057cc99e1737e20d0"
  user_data = <<-EOF
    #!/bin/bash
    sudo su -
    sudo yum update -y
    sudo yum install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo docker pull devesh11411/shop-ease:latest
    sudo docker run -d -p 80:4000 devesh11411/shop-ease:latest
  EOF

  tags = {
    Name = "shop-ease-Mumbai"
  }
}

resource "aws_instance" "app_virginia" {
  provider           = aws.us_east
  ami                = "ami-0ebfd941bbafe70c6"
  instance_type      = var.instance_type
  key_name           = var.key_pair
  availability_zone  = "us-east-1a"
  vpc_security_group_ids = [var.virginia_security_group_id]
  subnet_id = "subnet-0ffd86eb1548dbce6"

  user_data = <<-EOF
    #!/bin/bash
    sudo su -
    sudo yum update -y
    sudo yum install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo docker pull devesh11411/shop-ease:latest
    sudo docker run -d -p 80:4000 devesh11411/shop-ease:latest
  EOF

  tags = {
    Name = "shop-ease-Virginia"
  }
}
