variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "matomo"
}

variable "db_user" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "matomo"
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  default     = "matomopass"
  sensitive   = true
}

variable "matomo_image" {
  description = "Imagen de Matomo"
  type        = string
  default     = "doorsy/matomo-custom:latest"
}
