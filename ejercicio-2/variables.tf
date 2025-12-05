variable "db_name" {
  type    = string
  default = "matomo"
}

variable "db_user" {
  type    = string
  default = "matomo"
}

variable "db_password" {
  type      = string
  default   = "matomopass"
  sensitive = true
}