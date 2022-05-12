locals {
  backup_origin_list = try(jsondecode(var.backup_origin_list), var.backup_origin_list)
  backup_origin_type = try(jsondecode(var.backup_origin_type), var.backup_origin_type)
  https_switch       = try(jsondecode(var.https_switch), var.https_switch)
}

resource "tencentcloud_cdn_domain" "domain" {
  domain         = var.domain
  service_type   = var.service_type
  area           = var.area
  full_url_cache = var.full_url_cache

  origin {
    origin_type          = var.origin_type
    origin_list          = var.origin_list
    origin_pull_protocol = var.origin_pull_protocol

    dynamic "backup_origin_list" {
      for_each = local.backup_origin_list
      content {
        backup_origin_list = local.backup_origin_list
      }
    }

    dynamic "backup_origin_type" {
      for_each = local.backup_origin_type
      content {
        backup_origin_type = local.backup_origin_type
      }
    }
  }

  https_config {
    https_switch         = var.https_switch
    http2_switch         = var.http2_switch
    ocsp_stapling_switch = var.ocsp_stapling_switch
    spdy_switch          = var.spdy_switch
    verify_client        = var.verify_client

    dynamic "force_redirect" {
      for_each = local.https_switch
      content {
        switch               = lookup(local.https_switch, "switch", "on")
        redirect_type        = lookup(local.https_switch, "redirect_type", "http")
        redirect_status_code = lookup(local.https_switch, "redirect_status_code", "302")
      }
    }
  }

  tags = var.tags
}
