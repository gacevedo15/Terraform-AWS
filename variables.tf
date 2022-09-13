variable "cidr_vpc" {
    type = string
    description = "CIDR de VPC"
}

variable "cidr_subnet_public_1a" {
    type = string
    description = "CIDR de subnet public eu-west-1a"
}

variable "cidr_subnet_public_1b" {
    type = string
    description = "CIDR de subnet public eu-west-1b"
}

variable "cidr_subnet_private_1a" {
    type = string
    description = "CIDR de subnet private eu-west-1a"
}

variable "cidr_subnet_private_1b" {
    type = string
    description = "CIDR de subnet private eu-west-1b"
}