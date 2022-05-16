variable "project_scope_id" {
  type        = string
  description = "Scope ID for Boundary project"
}

variable "service_name" {
  type        = string
  description = "Name of Consul Service to register as a host and target in Boundary."
}

variable "service_address" {
  type        = string
  description = "IP address or DNS name for Consul service to register as a host in Boundary."
}

variable "service_port" {
  type        = number
  description = "Port of Consul service to register as a target in Boundary."
}
