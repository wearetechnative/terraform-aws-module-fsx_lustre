locals {
  dra_bucket_name = trimspace(coalesce(var.dra_bucket_name, ""))
  dra_single_enabled = var.create_dra && local.dra_bucket_name != ""
  dra_multi_enabled  = length(var.dra_directories) > 0
  dra_enabled        = local.dra_single_enabled || local.dra_multi_enabled
  dra_config = local.dra_multi_enabled ? var.dra_directories : (
    local.dra_single_enabled ? {
      default = {
        bucket_name      = local.dra_bucket_name
        file_system_path = "/"
      }
    } : {}
  )
}
