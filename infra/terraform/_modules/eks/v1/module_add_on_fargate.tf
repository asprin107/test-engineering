module "add-on" {
  source = "../../../_modules/add_on/fargate"

  volume_handle = "${module.app_of_apps.efs_id}::${module.app_of_apps.efs_access_point_id}" // volumeHandle: [FileSystemId]::[AccessPointId]

  tags = var.tags

  depends_on = [module.app_of_apps]
}