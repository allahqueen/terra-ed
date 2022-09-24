variable "demovpccidr" {
    description = "This is for vpc cidr"
    type = "strings"
    default = "10.0.0.0/16"
  
}
variable "subnet1cidr" {
    description = "This is cidr for my subnet"
    type = "strings"
    default = "10.0.0.0/24"
  
}
variable "AZ1" {
    description = "The Az for my subnet"
    type = "strings"
  
}