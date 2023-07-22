provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "demo-server" {
    ami ="ami-04823729c75214919"
    instance_type ="t2.micro"
    key_name ="dpp"
}