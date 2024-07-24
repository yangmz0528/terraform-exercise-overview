variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "size of managed EC2 instances"

  # Restrictions
  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type) # var.ec2_instance_type == "t2.micro" || var.ec2_instance_type == "t3.micro"
    error_message = "only support t2.micro and t3.micro"
  }
}

variable "ec2_volume_size" {
  type        = number
  description = "size (GB) of root block volume attached tomanaged EC2 instances"
}

variable "ec2_volume_type" {
  type        = string
  description = "volume type of between gp2 and gp3"
}