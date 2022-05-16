resource "boundary_host_catalog_static" "host_catalog" {


  name        = var.service_name
  description = "${var.service_name} host catalog created by Consul Terraform Sync"
  scope_id    = var.project_scope_id
}

resource "boundary_host_static" "host" {

  name            = var.service_name
  description     = "${var.service_name} host created by Consul Terraform Sync"
  host_catalog_id = boundary_host_catalog_static.host_catalog.id
  address         = var.service_address

  type = "static"
}

resource "boundary_host_set_static" "host_set" {
  name            = var.service_name
  description     = "${var.service_name} host set created by Consul Terraform Sync"
  host_catalog_id = boundary_host_catalog_static.host_catalog.id
  type            = "static"
  host_ids = [
    boundary_host_static.host.id
  ]
}

resource "boundary_target" "target" {

  name         = var.service_name
  type         = "tcp"
  description  = "${var.service_name} target created by Consul Terraform Sync"
  default_port = var.service_port
  scope_id     = var.project_scope_id
  host_source_ids = [
    boundary_host_set_static.host_set.id
  ]
}
