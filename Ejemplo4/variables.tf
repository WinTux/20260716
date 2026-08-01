variable "mi_region_aws" {
  type    = string
  default = "us-east-1"
}

variable "ruta_private_key" {
  description = "Ruta del archivo PEM para conexion SSH"
  type = string
}

variable "color_activo" {
  type = string
  default = "blue"
}
