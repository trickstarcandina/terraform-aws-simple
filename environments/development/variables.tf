variable "env" {
  description = "Environment"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "Region aws"
  type        = string
  default     = ""
}

variable "aws_allowed_account_id" {
  description = "List of allowed AWS account ids where resources can be created"
  type        = string
  default     = ""
}

variable "aws_access_key" {
  description = "Access key access AWS"
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = "Secret key access AWS"
  type        = string
  default     = ""
}

variable "network_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "network_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "network_azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = []
}

variable "network_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "network_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "keypair" {
  description = ""
  type        = string
  default     = ""
}
