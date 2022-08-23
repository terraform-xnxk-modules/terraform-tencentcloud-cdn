locals {
  response_header = {
    default = [
      {
        header_mode = "del"
        header_name = "Server"
        rule_type   = "all"
        rule_paths  = ["*"]
      }
    ],
    cors = [
      {
        header_mode  = "set"
        header_name  = "Access-Control-Allow-Origin"
        header_value = "*"
        rule_type    = "all"
        rule_paths   = ["*"]
      },
      {
        header_mode  = "set"
        header_name  = "Access-Control-Allow-Methods"
        header_value = "GET, HEAD"
        rule_type    = "all"
        rule_paths   = ["*"]
      },
      {
        header_mode  = "set"
        header_name  = "Access-Control-Allow-Headers"
        header_value = "Date, ETag, Last-Modified, Age"
        rule_type    = "all"
        rule_paths   = ["*"]
      }

    ]
  }

}
