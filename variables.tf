variable "domain" {
  type = string
}

variable "service_type" {
  default     = "web"
  description = "The type of service to create"
  type        = string
}

variable "area" {
  default     = "mainland"
  description = "The area to create the service in"
  type        = string
}

variable "full_url_cache" {
  default     = false
  description = "Whether to enable the full URL cache"
  type        = bool
}

variable "range_origin_switch" {
  default     = "off"
  description = "Whether to enable the range origin switch"
  type        = string
}

variable "ipv6_access_switch" {
  default     = "off"
  description = "Whether to enable IPv6 access switch"
  type        = string
}

variable "project_id" {
  default     = 0
  description = "The project ID to create the service in"
  type        = number
}

variable "origin" {
  default     = {}
  description = "The origin to use"
}

variable "origin_type" {
  default     = "ip"
  description = "The origin type"
  type        = string
}

variable "origin_list" {
  default     = []
  description = "The list of origins"
  type        = list(string)
}

variable "origin_pull_protocol" {
  default     = "follow"
  description = "The origin pull protocol"
  type        = string
}

variable "cos_private_access" {
  default     = "off"
  description = "Whether to enable COS private access"
  type        = string
}

variable "backup_origin_list" {
  default     = []
  description = "The list of backup origins"
  type        = list(string)
}

variable "backup_origin_type" {
  default     = "ip"
  description = "The backup origin type"
  type        = string
}

variable "https_config" {
  default     = {}
  description = "The HTTPS configuration to use for the service"
}

variable "rule_cache" {
  default     = {}
  description = "Whether to enable the rule cache"
}

variable "request_header_switch" {
  default     = "off"
  description = "Whether to enable the request header switch"
  type        = string
}

variable "request_header_rules" {
  default     = {}
  description = "Whether to enable the request header switch"
}

variable "response_header_switch" {
  default     = "off"
  description = "Whether to enable the response header switch"
  type        = string
}
variable "response_header_rules" {
  default     = {}
  description = "The request header configuration to use for the service"
}

variable "tags" {
  default     = {}
  description = "The tags to use for the service"
}

variable "https_switch" {
  default     = "on"
  description = "Whether to enable HTTPS"
  type        = string
}

variable "http2_switch" {
  default     = "on"
  description = "Whether to enable HTTP2"
  type        = string
}

variable "ocsp_stapling_switch" {
  default     = "on"
  description = "Whether to enable OCSP stapling"
  type        = string
}

variable "spdy_switch" {
  default     = "on"
  description = "Whether to enable SPDY"
  type        = string
}

variable "verify_client" {
  default     = "off"
  description = "Whether to verify client"
  type        = string
}
