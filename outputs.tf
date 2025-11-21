output "lustre_arn" {
  value       = aws_fsx_lustre_file_system.hpc.arn
  description = "ARN of the FSx-Lustre"
}

output "lustre_dns_name" {
  value = aws_fsx_lustre_file_system.hpc.dns_name
}

output "lustre_id" {
  value = aws_fsx_lustre_file_system.hpc.id
}

output "lustre_securitygroup_id" {
  value       = aws_security_group.fsx_sg.id
  description = "ID of the security_group created for the FSx-Lustre"
}

output "lustre_mountpoint" {
  value = aws_fsx_lustre_file_system.hpc.mount_name
}

output "data_repository_bucket_name" {
  description = "Name of the S3 bucket created for the data repository association (if enabled)."
  value       = local.dra_enabled ? aws_s3_bucket.lustre_repository["default"].bucket : null
}

output "data_repository_association_id" {
  description = "ID of the data repository association (if enabled)."
  value       = local.dra_enabled ? aws_fsx_data_repository_association.lustre_bucket["default"].id : null
}