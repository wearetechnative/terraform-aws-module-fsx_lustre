locals {
  dra_bucket_name = trimspace(coalesce(var.dra_bucket_name, ""))
  dra_enabled     = var.create_dra && local.dra_bucket_name != ""
  dra_config      = local.dra_enabled ? { default = local.dra_bucket_name } : {}

  lustre_repository_buckets = merge(
    { for key, bucket in aws_s3_bucket.lustre_repository : key => bucket },
    { for key, bucket in aws_s3_bucket.lustre_repository_retained : key => bucket }
  )
}