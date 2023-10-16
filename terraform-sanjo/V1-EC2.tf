provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo-server" {
    ami = "ami-041feb57c611358bd"
    instance_type = "t2.micro"
    key_name = "dpp"
}