variable "location" {
  default     = "East US"
  description = "Azure region for the resources"
}

variable "prefix" {
  description = "prefix of the deployment stage"
}

variable "vnetAdressSpace" {
  description = "adress space for vnet"
  type        = list(string)
}

variable "subnets" {
  type = map(object({
    name    = string
    address = string
  }))
}