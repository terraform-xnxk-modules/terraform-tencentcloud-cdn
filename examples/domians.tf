locals {
  domains = [
    {
      domain = "terraform-xnxk-modules-terraform-tencentcloud-cdn-examples.starubiquitous.com"
      origin = {
        origin_type = "domain"
        origin_list = [
          "starubiquitous-2gsi2q6140615857-1308277749.tcloudbaseapp.com"
        ]
      }
      https_config = merge(local.https_config, {
        server_certificate_config = {
          certificate_id = data.tencentcloud_ssl_certificates.starubiquitous-com.certificates.0.id
          message        = data.tencentcloud_ssl_certificates.starubiquitous-com.certificates.0.name
        }
      })
      rule_cache   = local.rule_cache.default
      response_header = concat(local.response_header.default, local.response_header.cors_rules)
    }
  ]
}

module "domain" {
  source = "../"

  for_each = {
    for domain in local.domains : domain.domain => {
      service_type        = can(domain.service_type) ? domain.service_type : "web"
      area                = can(domain.area) ? domain.area : "mainland"
      range_origin_switch = can(domain.range_origin_switch) ? domain.range_origin_switch : "off"
      full_url_cache      = can(domain.full_url_cache) ? domain.full_url_cache : true
      https_config        = try(domain.https_config, {})
      origin = {
        origin_type          = lookup(domain.origin, "origin_type", "ip")
        origin_list          = lookup(domain.origin, "origin_list", ["127.0.0.1"])
        origin_pull_protocol = lookup(domain.origin, "origin_pull_protocol", "http")
        cos_private_access   = lookup(domain.origin, "cos_private_access", "off")
        server_name          = try(domain.origin.origin_list.0, domain.domain)
      }
    rule_cache             = try(domain.rule_cache, [])
    request_header_switch  = can(domain.request_header) ? "on" : "off"
    request_header_rules   = try(domain.request_header, [])
    response_header_switch = can(domain.response_header) ? "on" : "off"
    response_header_rules  = try(domain.response_header, [])
    }
  }
  domain                 = each.key
  service_type           = each.value.service_type
  area                   = each.value.area
  range_origin_switch    = each.value.range_origin_switch
  full_url_cache         = each.value.full_url_cache
  https_config           = each.value.https_config
  origin                 = each.value.origin
  rule_cache             = each.value.rule_cache
  request_header_switch  = each.value.request_header_switch
  request_header_rules   = each.value.request_header_rules
  response_header_switch = each.value.response_header_switch
  response_header_rules  = each.value.response_header_rules
}
