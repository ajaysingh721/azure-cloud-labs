variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "rg" {
  description = "The name of the resource group to deploy resources"
  type        = string
}

variable "prefix" {
  description = "A prefix to add to all resources"
  type        = string
  default     = "acl"
}


variable "tenant_id" {
  description = "The tenant ID for the Azure subscription"
  type        = string

}
