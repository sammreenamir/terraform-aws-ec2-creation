# Step-by-Step Guide to Create 3 EC2 Instances on AWS Using Terraform

### **Step 1: Install Prerequisites**

#### **Install Terraform**

1. **Download Terraform:**

   First, update the package list and install required dependencies:

   ```bash
   sudo apt update
   sudo apt install -y wget unzip
   ```

   Then download the Terraform binary:

   ```bash
   wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
   ```

2. **Install Terraform:**

   Unzip the downloaded file and move the binary to `/usr/local/bin`:

   ```bash
   unzip terraform_1.7.5_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   ```

3. **Verify Installation:**

   Check that Terraform is correctly installed:

   ```bash
   terraform -v
   ```

---

#### **Install AWS CLI**

1. **Install AWS CLI:**

   If not already installed, update the package list and install the AWS CLI:

   ```bash
   sudo apt update
   sudo apt install awscli -y
   ```

2. **Configure AWS CLI:**

   Use the `aws configure` command to set up access keys and region:

   ```bash
   aws configure
   ```

   - Enter your AWS Access Key ID.
   - Enter your AWS Secret Access Key.
   - Choose your default region (e.g., `us-east-1`).
   - Default output format: `json`.

---

### **Step 2: Create a Terraform Configuration File**

1. **Create a Working Directory for Terraform:**

   On your remote VM, create a directory for your Terraform project:

   ```bash
   mkdir terraform-aws-vms
   cd terraform-aws-vms
   ```

2. **Create the `main.tf` File:**

   Create the `main.tf` Terraform configuration file:

   ```bash
   nano main.tf
   ```

3. **Add the Following Terraform Configuration:**

   Add the following code to `main.tf`:

   ```hcl
   # Define AWS provider
   provider "aws" {
     region = "us-east-1" # Change to your preferred AWS region
   }

   # Define AWS EC2 Instances
   resource "aws_instance" "example_vm" {
     count         = 3 # Create 3 VMs
     ami           = "ami-0c55b159cbfafe1f0" # Replace with your desired AMI ID
     instance_type = "t2.micro"

     tags = {
       Name = "terraform-vm-${count.index + 1}"
     }
   }

   # Output the VM information
   output "instance_ips" {
     description = "Public IP addresses of the VMs"
     value       = aws_instance.example_vm[*].public_ip
   }
   ```

   **Explanation**:
   - `provider`: Specifies AWS as the cloud provider.
   - `resource`: Defines 3 EC2 instances (`t2.micro` type) with a loop using `count`.
   - `output`: Displays the public IPs of the created VMs.

---

### **Step 3: Initialize Terraform**

1. **Initialize Terraform:**

   Run the following command in the `terraform-aws-vms` directory to initialize the Terraform configuration:

   ```bash
   terraform init
   ```

   - This command downloads the necessary provider plugins (e.g., AWS).

---

### **Step 4: Review the Plan**

1. **Generate and Review the Terraform Plan:**

   To see what Terraform will create, run the `plan` command:

   ```bash
   terraform plan
   ```

   - This will output the changes Terraform intends to make.

---

### **Step 5: Apply the Configuration**

1. **Apply the Configuration:**

   Run the following command to create the 3 EC2 instances:

   ```bash
   terraform apply
   ```

2. **Confirm the Apply:**

   When prompted, type `yes` to confirm.

3. **Terraform will provision 3 EC2 instances on AWS.** You’ll see output with the public IPs of the instances.

---

### **Step 6: Verify on AWS**

1. **Log in to your AWS Management Console.**
2. **Navigate to the EC2 Dashboard.**
3. **Check the 3 running instances with names:**
   - `terraform-vm-1`
   - `terraform-vm-2`
   - `terraform-vm-3`.

---

### **Step 7: Destroy the VMs (Optional)**

If you want to clean up the resources after testing:

1. **Run the Destroy Command:**

   ```bash
   terraform destroy
   ```

2. **Confirm the Destruction:**

   Type `yes` when prompted to destroy the instances.

---
