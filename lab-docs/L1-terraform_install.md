## Prepare Terraform Environment on Windows
As part of this, we should setup 
1. Terraform
2. VS Code
3. AWSCLI

### Install Terraform 
1. Download terraform the latest version from [here](https://developer.hashicorp.com/terraform/downloads)
2. Setup environment variable
click on start --> search "edit the environment variables" and click on it  
Under the advanced tab, chose "Environment variables" --> under the system variables select path variable   
and add terraform location in the path variable. system variables --> select path  
add new --> terraform_Path   
in my system, this path location is C:\Program Files\terraform_1.3.7

1. Run the below command to validate terraform version
   ```sh
   terraform -version
   ```
   the output should be something like below 
   ```sh
   Terraform v1.3.7
   on windows_386
   ```

 ### Install Visual Studio code

  Download vs code latest version from [here](https://code.visualstudio.com/download) and install it. 

### AWSCLI installation


Download AWSCLI latest version from [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and install it.

or you can run the below command in powershell or the command prompt

