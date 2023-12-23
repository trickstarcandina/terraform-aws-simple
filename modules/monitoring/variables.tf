variable "env" {
  description = "Environments"
  type        = string
  default     = ""
}

variable "region" {
  description = "Region"
  type        = string
  default     = ""
}

variable "target_group_arn_suffix" {
  description = ""
  type        = string
  default     = ""
}

variable "target_group_name" {
  description = ""
  type        = string
  default     = ""
}

variable "load_balancer_arn_suffix" {
  description = ""
  type        = string
  default     = ""
}

variable "load_balancer_name" {
  description = ""
  type        = string
  default     = ""
}
