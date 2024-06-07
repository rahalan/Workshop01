variable "location" {
  default     = "East US"
  description = "Azure region for the resources"
}

variable "prefix" {
  description = "prefix of the deployment stage"
}

variable "resource_group_name" {
  description = "name of the resource group"
}

variable "vnetAdressSpace" {
  description = "adress space for vnet"
  type        = list(string)
}

variable "subnets" {
  type = map(object({
    name    = string
    address = list(string)
  }))
}