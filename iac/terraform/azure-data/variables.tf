
variable "weather_db_username" {
    description = "service account credentias for weather database"
    type        = string
    default = "admin"
}

variable "weather_db_password" {
    description = "service account credentias for weather database"
    type        = string
    default = "Pa$$w0rd"
}


variable "rg" {
  description = "The name of the resource group to deploy resources"
  type        = string
}

