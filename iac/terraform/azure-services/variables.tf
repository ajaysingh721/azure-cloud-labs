
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

variable "ci_name" {
  description = "The name of the Container Instance"
  type        = string
  default     = "aclacr"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "aclci"
}

variable "act_tag_name" {
  description = "The name of the tag for the Azure Container Registry"
  type        = string
  default     = "v1"

}

