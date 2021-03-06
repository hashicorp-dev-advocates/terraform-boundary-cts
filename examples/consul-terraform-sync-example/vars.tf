# Boundary variables
variable "boundary_address" {
  type        = string
  description = "Boundary address"
  default     = "http://localhost:9200"
}

variable "project_scope_id" {
  type        = string
  description = "Scope ID for Boundary project"
  default     = "p_1234567890"
}

variable "auth_method_id" {
  type        = string
  description = "Auth method ID for Terraform to authenticate to."
}

variable "login_name" {
  type        = string
  description = "Login name for Terraform to authenticate with."
}

variable "password" {
  type        = string
  description = "Password for Terraform to authenticate with."
  sensitive   = true
}

#Consul Terraform Sync variables
variable "services" {
  description = "Consul services monitored by Consul-Terraform-Sync"
  type = map(
    object({
      id        = string
      name      = string
      kind      = string
      address   = string
      port      = number
      meta      = map(string)
      tags      = list(string)
      namespace = string
      status    = string

      node                  = string
      node_id               = string
      node_address          = string
      node_datacenter       = string
      node_tagged_addresses = map(string)
      node_meta             = map(string)

      cts_user_defined_meta = map(string)
    })
  )
}
