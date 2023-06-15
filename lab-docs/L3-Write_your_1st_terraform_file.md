## Write your 1st terraform file

Let's create an EC2 instance as part of our 1st terraform file

To create an ec2 instance, We should connect to aws account first 

in terraform file 
we can connect to AWS cloud using 'provider block'
to create an ec2 instance, should use 'resource block'
1. In the provider block, mention the cloud name, and region name 
   ```sh 
   provider "aws" {
   project = "acme-app"
   region  = "us-central1"
   }
   ```

1. In the resource block, We should mention information to create an instance. 
2. To create an EC2 instance (object), we should have the below information 
    - Instance name
    - Operating system (AMI)
    - instance Type 
    - Keypair
    - VPC
    - Storage
   
But among these, AMI id, instance type, and keypair are required arguments.
These should be defined in the resource block
```sh 
 resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
  keypair       = "demo_key"
 }
```

So the final file looks [like this](v1-ec2.tf)
