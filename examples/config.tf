locals {
  https_config = {
    switch = "on"
    force_redirect = {
      switch               = "on"
      redirect_type        = "https"
      redirect_status_code = 302
    }
  }
}
