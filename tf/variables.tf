variable "domain_name" {
  type        = string
  description = "Domain name of the website"
}

variable "bucket_name" {
  type        = string
  description = "Name of the bucket without the www.prefix. Ideally domain_name"
}

variable "common_tags" {
  description = "Common tags applied to all components"
}