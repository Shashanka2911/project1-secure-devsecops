variable "vpc_name" {
    description = "Name of the VPC"
    type        = string
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "availability_zones" {
    description = "Availability zones for the VPC"
    type        = list(string)
}

variable "private_subnets" {
    description = "Private subnet CIDR blocks"
    type        = list(string)
}

variable "public_subnets" {
    description = "Public subnet CIDR blocks"
    type        = list(string)
}