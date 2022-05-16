locals {
  # Group service instances by service name
  consul_services = {
    for id, s in var.services : s.name => s...
  }
}

module "boundary_resources" {
  for_each = var.services

  source = "github.com/hashicorp-dev-advocates/terraform-cts-boundary"

  project_scope_id = "p_1234567890"
  service_name     = each.value["name"]
  service_address  = each.value["address"]
  service_port     = each.value["port"]

}