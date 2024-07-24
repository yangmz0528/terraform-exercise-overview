locals {
  name = "xiao ming"
  age  = -15
  my_object = {
    key1 = 10
    key2 = "my_value"
  }
}

output "example1" {
  value = startswith(lower(local.name), "john")
}

output "example2" {
  value = abs(local.age * 2)
}

output "example3" {
  value = pow(local.age, 2)
}

output "example4" {
  # value = file("${path.module}/users.yaml")
  value = yamldecode(file("${path.module}/users.yaml")).users[*].name
}

output "example5" {
  value = jsonencode(local.my_object)
}