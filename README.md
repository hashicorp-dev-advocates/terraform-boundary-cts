# Boundary module for Consul Terraform Sync

This module creates a Boundary host, host set, host catalog and target for each service registered in Consul. The module is designed to be used by Consul Terraform Sync to keep host and target connectivity details up-to-date with the Consul service mesh as the source of truth.

## Example Consul Terraform Sync file using this module

```hcl
log_level   = "INFO"
working_dir = "."
port        = 8558

syslog {}

buffer_period {
  enabled = true
  min     = "5s"
  max     = "20s"
}

consul {
  address = "localhost:8500"
}

driver "terraform" {
  log         = false
  persist_log = false

  backend "consul" {
    gzip = true
  }
}

task {
 name        = "cts-boundary-example"
 description = "Example task with two services being monitored"
 module      = "/Users/robertbarnes/Documents/github.com/hashicorp-dev-advocates/terraform-module-boundary-target"
# version     = "0.1.0" 
 condition "services" {
  names = ["web", "api"]
 }
}
```