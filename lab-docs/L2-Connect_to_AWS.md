## Connect to AWS Cloud

You must have an AWS account to proceed with the below steps.
1. Create an IAM programmatic user with administrator access
2. Configure credentials
   ```sh
   aws configure --profile <profile_name>
   ```
3. Test the connection
   ```sh
   aws s3 ls
   ```
   