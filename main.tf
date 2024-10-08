resource "aws_fsx_lustre_file_system" "hpc" {

  storage_capacity                = var.storage_capacity
  data_compression_type           = var.data_compression_type
  automatic_backup_retention_days = var.backup_retention_days
  deployment_type                 = var.deployment_type
  per_unit_storage_throughput     = var.unit_storage_throughput
  subnet_ids                      = var.subnet_ids
  weekly_maintenance_start_time   = var.weekly_maintenance_start_time
  log_configuration {
    destination = var.log_destination
    level       = var.log_level
  }
}
