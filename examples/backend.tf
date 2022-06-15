terraform {
  backend "cos" {
    bucket = "terraform-state-1308277749"
    region = "ap-chengdu"
    key    = "terraform-xnxk-modules/terraform-tencentcloud-cdn/examples/terraform.tfstate"
  }
}
