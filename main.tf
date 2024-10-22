resource "aws_fsx_lustre_file_system" "hpc" {

  storage_capacity                = var.storage_capacity
  data_compression_type           = var.data_compression_type
  automatic_backup_retention_days = var.backup_retention_days
  deployment_type                 = var.deployment_type
  per_unit_storage_throughput     = var.unit_storage_throughput
  subnet_ids                      = var.subnet_ids
  weekly_maintenance_start_time   = var.weekly_maintenance_start_time
  security_group_ids = [aws_security_group.fsx_sg.id]

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


data "aws_subnet" "selected" {
  id = var.subnet_ids[0] 
}


resource "aws_cloudwatch_log_group" "lustre" {
    count = var.log_retention_days != null ? 1 : 0
  name = "/aws/fsx/lustre/lustre-${var.fsx_id}"
  retention_in_days = 7
} 

resource "aws_security_group" "fsx_sg" {
  name        = "fsx_lustre_sg"
  description = "Allow Lustre LNET traffic"
  vpc_id      = data.aws_subnet.selected.vpc_id

  ingress {
    description = "Allow Lustre LNET traffic"
    from_port   = 988
    to_port     = 988
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Or limit to your specific CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

tags = {
        TechNativeModule = "true"
        Name = "fsx_lustre_sg-${var.fsx_id}"
          }
}

