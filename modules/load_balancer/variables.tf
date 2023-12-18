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

variable "public_subnets" {
  description = ""
  type        = list(string)
  default     = []
}
