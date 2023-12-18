variable "env" {
    description = "Environments"
    type        = string
    default     = ""
}

variable "vpc_id" {
    description = ""
    type        = string
    default     = ""
}

variable "private_subnets" {
    description = "Environments"
    type        = list(string)
    default     = []
}

variable "availability_zone" {
    description = ""
    type        = string
    default     = ""
}

variable "security_group_webserver" {
    description = ""
    type        = string
    default     = ""
}