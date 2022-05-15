locals {
  # Group service instances by service name
  consul_services = {
    for id, s in var.services : s.name => s...
  }
}

resource "boundary_host_catalog" "host_catalog" {

  for_each = var.services

  name        = each.value["name"]
  description = "${each.value["name"]} host catalog created by Consul Terraform Sync"
  type        = "static"
  scope_id    = var.project_scope_id
}

resource "boundary_host" "host" {

  for_each = var.services

  name            = each.value["name"]
  description     = "${each.value["name"]} host created by Consul Terraform Sync"
  host_catalog_id = boundary_host_catalog.host_catalog[each.key].id
  address         = each.value["address"]

  type = "static"
}

resource "boundary_host_set" "host_set" {
  for_each = var.services

  name            = each.value["name"]
  description     = "${each.value["name"]} host set created by Consul Terraform Sync"
  host_catalog_id = boundary_host_catalog.host_catalog[each.key].id
  type            = "static"
  host_ids = [
    boundary_host.host[each.key].id
  ]
}

resource "boundary_target" "target" {
  for_each = var.services

  name         = each.value["name"]
  type         = "tcp"
  description  = "${each.value["name"]} target created by Consul Terraform Sync"
  default_port = each.value["port"]
  scope_id     = var.project_scope_id
  host_source_ids = [
    boundary_host_set.host_set[each.key].id
  ]
}
