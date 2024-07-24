locals {
  firstname_from_splat         = var.objects_list[*].firstname # only works for list
  roles_from_splat             = [for username, user_props in local.users_map2 : user_props.roles]
  roles_from_splat_with_values = values(local.users_map2)[*].roles # same as roles from splat
}

output "firstnames_from_splat" {
  value = local.firstname_from_splat
}

output "roles_from_splat" {
  value = local.roles_from_splat
}