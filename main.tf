# Define AWS provider
provider "aws" {
  region = "us-east-1"
}

# Define AWS EC2 Instances
resource "aws_instance" "example_vm" {
  count         = 3 # Create 3 VMs
  ami           = "ami-0e2c8caa4b6378d8c" 
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

