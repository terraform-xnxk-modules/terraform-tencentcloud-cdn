locals {
  origin             = try(jsondecode(var.origin), var.origin)
  backup_origin_list = try(jsondecode(var.backup_origin_list), var.backup_origin_list)
  backup_origin_type = try(jsondecode(var.backup_origin_type), var.backup_origin_type)
  https_config       = try(jsondecode(var.https_config), var.https_config)
  rule_cache         = try(jsondecode(var.rule_cache), var.rule_cache)
  request_header     = try(jsondecode(var.request_header), var.request_header)
}

resource "tencentcloud_cdn_domain" "domain" {
  domain              = var.domain
  service_type        = var.service_type
  area                = var.area
  full_url_cache      = var.full_url_cache
  range_origin_switch = var.range_origin_switch
  ipv6_access_switch  = var.ipv6_access_switch

  https_config {
    https_switch         = lookup(local.https_config, "https_switch", "on")
    http2_switch         = lookup(local.https_config, "http2_switch", "on")
    ocsp_stapling_switch = lookup(local.https_config, "ocsp_stapling_switch", "on")
    spdy_switch          = lookup(local.https_config, "spdy_switch", "off")
    verify_client        = lookup(local.https_config, "verify_client", "off")

    force_redirect {
      switch               = lookup(local.https_config, "switch", "off")
      redirect_type        = lookup(local.https_config, "redirect_type", "https")
      redirect_status_code = lookup(local.https_config, "redirect_status_code", "302")
    }

    server_certificate_config {
      certificate_id = lookup(local.https_config.server_certificate_config, "certificate_id", null)
      message        = lookup(local.https_config.server_certificate_config, "message", null)
    }

  }

  origin {

    origin_type          = lookup(local.origin, "origin_type", "ip")
    origin_list          = lookup(local.origin, "origin_list", ["127.0.0.1"])
    origin_pull_protocol = lookup(local.origin, "origin_pull_protocol", "follow")
    cos_private_access   = lookup(local.origin, "cos_private_access", "off")

    server_name = lookup(local.origin, "server_name", var.domain)

    #      dynamic "backup_origin_list" {
    #        for_each = local.backup_origin_list
    #        content {
    #          backup_origin_list = local.backup_origin_list
    #        }
    #      }
    #
    #      dynamic "backup_origin_type" {
    #        for_each = local.backup_origin_type
    #        content {
    #          backup_origin_type = local.backup_origin_type
    #        }
    #      }
  }

  dynamic "rule_cache" {
    for_each = length(local.rule_cache) == 0 ? [] : local.rule_cache
    content {
      cache_time           = lookup(rule_cache.value, "cache_time", 300)
      compare_max_age      = lookup(rule_cache.value, "compare_max_age", "off")
      follow_origin_switch = lookup(rule_cache.value, "follow_origin_switch", "off")
      ignore_cache_control = lookup(rule_cache.value, "ignore_cache_control", "off")
      ignore_set_cookie    = lookup(rule_cache.value, "ignore_set_cookie", "off")
      no_cache_switch      = lookup(rule_cache.value, "no_cache_switch", "off")
      re_validate          = lookup(rule_cache.value, "re_validate", "off")
      rule_paths           = lookup(rule_cache.value, "rule_paths", ["*"])
      rule_type            = lookup(rule_cache.value, "rule_type", "all")
      switch               = lookup(rule_cache.value, "switch", "on")
    }
  }

  request_header {
    switch = lookup(local.request_header, "switch", "off")
    dynamic "header_rules" {
      for_each = length(lookup(local.request_header, "header_rules", [])) == 0 ? [] : local.request_header.header_rules
      content {
        header_mode  = lookup(local.request_header.header_rules, "header_mode", "add")
        header_name  = local.request_header.header_rules.header_name
        header_value = local.request_header.header_rules.header_value
        rule_paths   = lookup(local.request_header.header_rules, "rule_paths", ["*"])
        rule_type    = lookup(local.request_header.header_rules, "rule_type", "all")
      }
    }
  }

  tags = var.tags
}
