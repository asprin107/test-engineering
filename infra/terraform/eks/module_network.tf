module "network" {
  source = "../_modules/network/basic"

  project = var.project
  region  = var.aws_region
}