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

variable "subnet_ids" {
    description = ""
    type        = list(string)
    default     = []
}

variable "multi_az_enabled" {
    description = ""
    type        = bool
    default     = false
}

variable "automatic_failover_enabled" {
    description = ""
    type        = bool
    default     = true
}

variable "node_type" {
    description = ""
    type        = string
    default     = "cache.t3.micro"
}

variable "num_cache_clusters" {
    description = ""
    type        = number
    default     = 1
}

variable "parameter_group_name" {
    description = ""
    type        = string
    default     = "default.redis7"
}

variable "security_group_webserver" {
    description = ""
    type        = string
    default     = ""
}
