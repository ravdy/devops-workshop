provider "aws" {
  region = "us-east-1"
}

 resource "aws_instance" "demo-server" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name      = "dppa"
  //security_groups = [ "demo-sg" ]
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
   subnet_id = aws_subnet.dpw-public_subent_01.id

 }
 resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "SSH Access"
  vpc_id = aws_vpc.dppa-vpc_id

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      =  ["0.0.0.0/0"] 
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh-port"
  }
  }

    resource "aws_vpc" "DPPA-vpc" {
       cidr_block = "10.1.0.0/16"
       tags = {
        Name = "dppa-vpc"
     }
   }

   resource "aws_subnet" "dppa-public_subent_01" {
    vpc_id = aws_vpc.dppa-vpc.id
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
      Name = "dppa-public_subent_01"
    }
}

   resource "aws_subnet" "dppa-public_subent_02" {
    vpc_id = aws_vpc.dppa-vpc.id
    cidr_block = "10.1.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
    tags = {
      Name = "dppa-public_subent_02"
    }
}

resource "aws_internet_gateway" "dppa-igw" {
    vpc_id = aws_vpc.dppa-vpc.id
    tags = {
      Name = "dppa-igw"
    }
}

resource "aws_route_table" "dppa-public-rt" {
    vpc_id = aws_vpc.dppa-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dppa-igw.id
    }
    tags = {
      Name = "dppa -public-rt"
    }
}

resource "aws_route_table_association" "dppa-rta-public-subent-1" {
    subnet_id = aws_subnet.dppa-public_subent_01.id
    route_table_id = aws_route_table.dppa-public-rt.id
}


resource "aws_route_table_association" "dppa-rta-public-subent-2" {
    subnet_id = aws_subnet.dppa-public_subent_02.id
    route_table_id = aws_route_table.dppa-public-rt.id
}