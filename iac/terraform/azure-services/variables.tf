variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "rg" {
  description = "The name of the resource group to deploy resources"
  type        = string
  default     = "1-0838e53c-playground-sandbox"
}

variable "prefix" {
  description = "A prefix to add to all resources"
  type        = string
  default     = "acl"
}
