output "lustre_arn" {
  value = aws_fsx_lustre_file_system.hpc.arn
}

output "lustre_dns_name" {
  value = aws_fsx_lustre_file_system.hpc.dns_name
}

output "lustre_securitygroup_id" {
  value = aws_security_group.fsx_sg.id
}
