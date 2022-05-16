provider "boundary" {
  addr = var.boundary_address

  auth_method_id                  = var.auth_method_id
  password_auth_method_login_name = var.login_name
  password_auth_method_password   = var.password
}
