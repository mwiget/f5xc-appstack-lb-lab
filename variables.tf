variable "project_prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = "prefix"
}

variable "namespace" {
  type        = string
}

variable "f5xc_api_url" {       
  type = string
}

variable "f5xc_api_cert" {
  type = string
  default = ""
}

variable "f5xc_api_p12_file" {
  type = string
  default = ""
}

variable "f5xc_api_key" {
  type = string
  default = ""
}

variable "f5xc_api_ca_cert" {
  type = string
  default = ""
}

variable "f5xc_api_token" {
  type = string
  default = ""
}

variable "f5xc_tenant" {
  type = string
  default = ""
}

variable "appstack_site" {
  type = string
}

variable "delegated_domain" {
  type = string
}

