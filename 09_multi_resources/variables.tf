variable "subnet_count" {
  type    = number
  default = 2
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  # Ensure that only t2.micro is used
  # 1. Map from the object to the instance_type
  # 2. Map from the instance_type to a boolean indicating whether the value equals to t2.micro
  # 3. Check whether the list of booleans contains only true
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instances are allowed"
  }

  # Ensure that only ubuntu and nginx images are used
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["nginx", "ubuntu"], config.ami)
    ])
    error_message = "Only \"ubuntu\" and \"nginx\" images are allowed"
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_index  = optional(number, 0)
  }))

  # Ensure that only t2.micro is used
  validation {
    condition = alltrue([
      for key, config in var.ec2_instance_config_map : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instances are allowed"
  }

  # Ensure that only ubuntu and nginx images are used
  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["nginx", "ubuntu"], config.ami)
    ])
    error_message = "Only \"ubuntu\" and \"nginx\" images are allowed"
  }
}