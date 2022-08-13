terraform {
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">=1.77.1"
    }
  }
  required_version = ">= 1.0.11"
}
