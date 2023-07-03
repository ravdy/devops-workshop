## Setup Kubernetes cluster using terraform 
1. EKS module code is available over [here](https://github.com/ravdy/RTP-03/tree/main/terraform/v7-EC2_VPC_and_EKS/eks)  
   Through this eks module we are creating  
     - IAM Roles
     - IAM Policies
     - EKS Cluster
     - Node Group

1. Copy eks and sg_eks modules onto terraform folder  
2. Create vpc folder and move existing files inside to this  
3. Add sg_eks module and eks modules in the vpc.tf file 
   ```sh 
     module "sgs" {
       source = "../sg_eks"
       vpc_id     =     aws_vpc.dpp-vpc.id
    }

     module "eks" {
          source = "../eks"
          vpc_id     =     aws_vpc.dpp-vpc.id
          subnet_ids = [aws_subnet.dpp-public-subnet-01.id,aws_subnet.dpp-public-subnet-02.id]
          sg_ids = module.sgs.security_group_public
    }
   ```
 by this time we are ready with our terraform modules to create a cluster 