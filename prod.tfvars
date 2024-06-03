prefix          = "prod"
vnetAdressSpace = ["10.1.0.0/16"]
subnets = {
  "subnet01" = {
    name    = "subnet01"
    address = "10.1.0.0/24"
  }
  "subnet02" = {
    name    = "subnet02"
    address = "10.1.1.0/24"
  }
  "subnet03" = {
    name    = "subnet03"
    address = "10.1.2.0/24"
  }
}