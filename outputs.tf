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

output "data_repository_bucket_names" {
  description = "Map of data repository bucket names keyed by the association identifier."
  value       = { for key, bucket in aws_s3_bucket.lustre_repository : key => bucket.bucket }
}

output "data_repository_association_ids" {
  description = "Map of data repository association IDs keyed by the association identifier."
  value       = { for key, assoc in aws_fsx_data_repository_association.lustre_bucket : key => assoc.id }
}
