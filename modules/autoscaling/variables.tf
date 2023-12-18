variable "env" {
  description = "Environments"
  type        = string
  default     = ""
}

variable "launch_template_id" {
  description = ""
  type        = string
  default     = ""
}

variable "vpc_zone_identifier" {
  description = ""
  type        = list(string)
  default     = []
}

variable "lb_target_group_arn" {
  description = ""
  type        = string
  default     = ""
}