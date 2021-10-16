provider "aws" {
  profile    = "default"
  region     = "ap-southeast-1"
}
resource "aws_s3_bucket" "codeexample" {
  bucket = "code"
  acl    = "private"
}

data "aws_vpc" "main" {
  id       = "vpc-xxxxxx"
  tags = {
    Name = "main"
  }
}
data "aws_security_group" "test-vpc" {
  name = "test-vpc"
  id = "sg-xxxxxxx"
}

data "aws_subnet" "Private-subnet-b" {
  id = "subnet-xxxxxx"
}

data "aws_iam_role" "user-roles" {
  name = "user-roles"
}

resource "aws_codebuild_project" "codeexample" {
  name          = "code-service"
  description   = "test_codebuild_service"
  build_timeout = "5"
  service_role  = "arn:aws:iam::xxxxxxx:role/user-roles"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.codeexample.bucket}"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/bagusdeo/test.git"
    git_clone_depth = 1
  }

}