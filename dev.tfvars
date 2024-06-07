prefix              = "dev"
resource_group_name = "rg-rahalan"
vnetAdressSpace     = ["10.0.0.0/16"]
subnets = {
  "subnet01" = {
    name    = "subnet01"
    address = ["10.0.0.0/24"]
  }
  "subnet02" = {
    name    = "subnet02"
    address = ["10.0.1.0/24"]
  }
}