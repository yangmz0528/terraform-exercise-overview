locals {
  project_owner = "terraform-course"
  cost_center   = "1234"
  managed_by    = "terraform"
}

locals {
  common_tags = {
    owner       = local.project_owner
    cost_center = local.cost_center
    managed_by  = local.managed_by
  }
}
