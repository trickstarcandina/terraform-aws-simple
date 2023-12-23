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

variable "public_subnet_ids" {
  description = ""
  type        = list(string)
  default     = []
}

variable "keypair" {
  description = ""
  type        = string
  default     = ""
}

variable "instance_type" {
  description = ""
  type        = string
  default     = "t2.micro"
}

variable "image_id" {
  description = ""
  type        = string
  default     = "ami-0f98860b8bc09bd5c"
}

variable "security_group_alb" {
  description = ""
  type        = string
  default     = ""
}
