variable "mi_region_aws" {
  type    = string
  default = "us-east-1"
}
variable "nombres_servicios" {
  description = "Nombre de los repositoriosde EC2"
  type        = set(string)
}

variable "nombres_servicios_2" {
  description = "Nombre de los repositorios de EC2 para una segunda subred"
  type        = set(string)
}

