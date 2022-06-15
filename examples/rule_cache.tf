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
