# Terraform file to create VPC and EC2 
So far, we have created an EC2 instance with the Security group. Now let's create these in a separate VPC.
For that, we need to create VPC first. 

In VPC, there are various steps involved. 
1. Create VPC
2. Create a Subnet
3. Create Internet Gateway
4. Create RouteTable 
5. Route Table Association 

## let's create one by one 

### 1. Create VPC

To create a VPC, we need a CIDR block. So the resource block looks like the below. 
   ```sh 
     resource "aws_vpc" "dpw-vpc" {
          cidr_block = "10.1.0.0/16"
          tags = {
           Name = "dpw-vpc"
        }
      }
   ```

### 2. Create Subnet 
We should create a subnet under VPC. So we should mention VPC's name over here. But we get VPC once the resource is created right. so to pull up name dynamically, we can use "resource_name.resource_label.id" In this case, it is going to be 
`aws_vpc.dpw-vpc.id`

So the subnet snippet looks like the one below. 

```sh 
//Create a Subnet 
resource "aws_subnet" "dpw-public_subent_01" {
    vpc_id = aws_vpc.dpw-vpc.id
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
      Name = "dpw-public_subent_01"
    }
}
```

### 3. Create Internet Gateway

We should create an internet gateway and add this to VPC for this 

```sh 
//Creating an Internet Gateway 
resource "aws_internet_gateway" "dpw-igw" {
    vpc_id = aws_vpc.dpw-vpc.id
    tags = {
      Name = "dpw-igw"
    }
}
```

#### 4. Create route table 

```sh 
// Create a route table 
resource "aws_route_table" "dpw-public-rt" {
    vpc_id = aws_vpc.dpw-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dpw-igw.id
    }
    tags = {
      Name = "dpw-public-rt"
    }
}
```
# 5. Route table association 

```sh 
// Associate subnet with route table

resource "aws_route_table_association" "dpw-rta-public-subent-1" {
    subnet_id = aws_subnet.dpw-public_subent_01.id
    route_table_id = aws_route_table.dpw-public-rt.id
}
``` 

after this [terraform v3 file]() looks like this