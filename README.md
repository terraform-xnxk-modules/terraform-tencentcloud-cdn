# TencentCloud CDN Terraform module

[![Tests](https://github.com/terraform-xnxk-modules/terraform-tencentcloud-cdn/actions/workflows/tests.yml/badge.svg)](https://github.com/terraform-xnxk-modules/terraform-tencentcloud-cdn/actions/workflows/tests.yml)

Terraform module which creates CDN domains on TencentCloud.

## Features

This module aims to implement ALL combinations of arguments supported by TencentCloud and latest stable version of Terraform:

- Create domain
- Origin
  - 🚧 backup origin
- 🚧 Referer
- HTTPS
  - https switch
  - http2 switch
  - ocsp stapling switch
  - spdy switch
  - force redirect
- Cache Rule
- Header Rule

If there is a missing feature or a bug - [open an issue](https://github.com/terraform-xnxk-modules/terraform-tencentcloud-cdn/issues/new).

## Terraform versions

Recommended use Terraform 1.0 or later version of this module.

## Usage

### Basic

First you need to define the module.

```terraform

module "domain" {
  source  = "terraform-xnxk-modules/cdn/tencentcloud"
  version = ">=1.3.1"

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
      rule_cache = try(domain.rule_cache, [])
    }
  }
  domain              = each.key
  service_type        = each.value.service_type
  area                = each.value.area
  range_origin_switch = each.value.range_origin_switch
  full_url_cache      = each.value.full_url_cache
  https_config        = each.value.https_config
  origin              = each.value.origin
  rule_cache          = each.value.rule_cache
}

```

Next you need to define the cdn domains.

```terraform

locals {
  domains = [
    {
      domain = "www.xnxk.net"
      area   = "global"
      origin = {
        origin_type = "domain"
        origin_list = [
          "xnxk-6g7yy2mi9f17f856-1308277749.tcloudbaseapp.com"
        ]
      }
      https_config = {
        switch = "on"
        server_certificate_config = {
          certificate_id = data.tencentcloud_ssl_certificates.xnxk-net.certificates.0.id
          message        = data.tencentcloud_ssl_certificates.xnxk-net.certificates.0.name
        }
      }
      rule_cache = local.rule_cache.default
    }
  ]
}
```

### Rule Cache

You can define default cache rule for some domain.

```terraform
locals {
  rule_cache = {
    default = [
      {
        cache_time           = "2592000"
        compare_max_age      = "off"
        follow_origin_switch = "off"
        ignore_cache_control = "off"
        ignore_set_cookie    = "off"
        no_cache_switch      = "off"
        re_validate          = "off"
        rule_paths           = ["*"]
        rule_type            = "all"
        switch               = "on"
      },
      {
        cache_time           = "2592000"
        compare_max_age      = "off"
        follow_origin_switch = "off"
        ignore_cache_control = "off"
        ignore_set_cookie    = "off"
        no_cache_switch      = "on"
        re_validate          = "off"
        rule_paths           = ["php", "jsp", "asp", "aspx"]
        rule_type            = "file"
        switch               = "off"
      }
    ]
  }
}
```

## Outputs

WIP

## License

The code in this repository, unless otherwise noted, is under the terms of both the [Anti 996](https://github.com/996icu/996.ICU/blob/master/LICENSE) License and the [Apache License (Version 2.0)](./LICENSE-APACHE).
