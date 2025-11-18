locals {
  dra_bucket_name = trimspace(coalesce(var.dra_bucket_name, ""))
  dra_enabled     = var.create_dra && local.dra_bucket_name != ""
  dra_config      = local.dra_enabled ? { default = local.dra_bucket_name } : {}
}