resource "aws_fsx_lustre_file_system" "hpc" {

  storage_capacity                = var.storage_capacity
  data_compression_type           = var.data_compression_type
  automatic_backup_retention_days = var.backup_retention_days
  deployment_type                 = var.deployment_type
  per_unit_storage_throughput     = var.unit_storage_throughput
  subnet_ids                      = var.subnet_ids
  weekly_maintenance_start_time   = var.weekly_maintenance_start_time
	dynamic "log_configuration" {
    for_each = var.log_retention_days != null && var.log_level != null ? [1] : []

    content {
      destination = aws_cloudwatch_log_group.lustre[0].arn
      level       = var.log_level
    }
  }

  tags = {
        Name = var.fsx_id
          }
}

resource "aws_cloudwatch_log_group" "lustre" {
    count = var.log_retention_days != null ? 1 : 0
  name = "/aws/fsx/lustre/lustre-${var.fsx_id}"
  retention_in_days = 7
}


