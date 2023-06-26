## Setup Kubernetes cluster using terraform 
1. EKS module code is available over [here](https://github.com/ravdy/RTP-03/tree/main/terraform/v7-EC2_VPC_and_EKS/eks)  
   Through this eks module we are creating  
     - IAM Roles
     - IAM Policies
     - EKS Cluster
     - Node Group

1. Copy eks and sg_eks modules onto terraform folder  
2. Create vpc folder and move existing files inside to this  

3. Add one extra subnet in vpc.tf file

   ```sh
   // Create 2nd a Subnet
   resource "aws_subnet" "dpw-public_subnet_02" {
      vpc_id = aws_vpc.dpw-vpc.id
      cidr_block = "10.1.2.0/24"
      map_public_ip_on_launch = "true"
      availability_zone = "us-east-1b"
      tags = {
           Name = "dpw-public_subnet_02"
        }
    }
   ``` 

4. Add additional subnet association in the vpc.tf file

   ```sh 
    resource "aws_route_table_association" "rtp03-rta-public-subnet-2" {
    subnet_id = aws_subnet.dpw-public_subnet_02.id
    route_table_id = aws_route_table.dpw-public-rt.id

    }
   ```

6. Add sg_eks module and eks modules in the vpc.tf file 
   ```sh 
     module "sgs" {
       source = "../sg_eks"
       vpc_id     =     aws_vpc.dpw-vpc.id
    }

     module "eks" {
          source = "../eks"
          vpc_id     =     aws_vpc.dpw-vpc.id
          subnet_ids = [aws_subnet.dpw-public_subent_01.id,aws_subnet.dpw-public_subent_02.id]
          sg_ids = module.sgs.security_group_public
    }
   ```
 by this time we are ready with our terraform modules to create a cluster 