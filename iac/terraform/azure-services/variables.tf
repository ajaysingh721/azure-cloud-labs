
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

variable "aci_name" {
  description = "The name of the Container Instance"
  type        = string
  default     = "aclacr"
}

variable "web_app_name" {
  description = "The name of the Web App"
  type        = string
  default     = "aclweb"

}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "aclci"
}

variable "acr_image_name" {
  description = "The name of the image in the Azure Container Registry"
  type        = string
  default     = "aclwebimage"
}

variable "tag_name" {
  description = "The name of the tag for the Azure Container Registry"
  type        = string
  default     = "latest"
}

variable "image" {
  type        = string
  description = "Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials."
  default     = "mcr.microsoft.com/azuredocs/aci-helloworld"
}

variable "port" {
  type        = number
  description = "Port to open on the container and the public IP address."
  default     = 80
}

variable "cpu_cores" {
  type        = number
  description = "The number of CPU cores to allocate to the container."
  default     = 1
}

variable "memory_in_gb" {
  type        = number
  description = "The amount of memory to allocate to the container in gigabytes."
  default     = 2
}

variable "restart_policy" {
  type        = string
  description = "The behavior of Azure runtime if container has stopped."
  default     = "Always"
  validation {
    condition     = contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "The restart_policy must be one of the following: Always, Never, OnFailure."
  }
}

