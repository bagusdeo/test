provider "aws" {
  profile    = "default"
  region     = "ap-southeast-1"
}

data "aws_vpc" "main" {
  id       = "vpc-xxxxxx"
  tags = {
    Name = "main"
  }
}

data "aws_security_group" "test-vpc" {
  name = "test-vpc"
  id = "sg-xxxxxxxxxxxx"
}

data "aws_subnet" "Private-subnet" {
  id = "subnet-xxxxxx"
}

data "aws_iam_role" "user-roles" {
  name = "user-roles"
}

resource "aws_instance" "testing-elastic" {

ami = "ami-xxxxxxxxxxxxx"
instance_type = "t3a.small"
key_name = "test"
count = 1
iam_instance_profile = data.aws_iam_role.user-roles.id
vpc_security_group_ids = [data.aws_security_group.test-vpc.id]
subnet_id              = data.aws_subnet.Private-subnet.id
tags = {
Name = "testing-elastic"
}
}
resource "aws_eip" "main" {
    count = "1"
    vpc = true
    depends_on = ["aws_instance.testing-elastic"]
}