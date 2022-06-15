terraform {
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">=1.72.0"
    }
  }
  required_version = ">= 1.0.11"
}
