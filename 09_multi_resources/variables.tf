variable "subnet_config" {
  type = map(object(
    {
      cidr_block = string
    }
  ))

  # Ensure all provided CIDR blocks are valid
  validation {
    condition     = alltrue([for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))])
    error_message = "At least one of the provided cidr_block is not valid"
  }
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))
  default = []

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
    subnet_name   = optional(string, "default")
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