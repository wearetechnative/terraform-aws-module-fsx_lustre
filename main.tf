resource "aws_fsx_lustre_file_system" "hpc" {

  storage_capacity                = var.storage_capacity
  data_compression_type           = var.data_compression_type
  automatic_backup_retention_days = var.backup_retention_days
  deployment_type                 = var.deployment_type
  per_unit_storage_throughput     = var.unit_storage_throughput
  subnet_ids                      = var.subnet_ids
  weekly_maintenance_start_time   = var.weekly_maintenance_start_time
  security_group_ids              = [aws_security_group.fsx_sg.id]

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
  count             = var.log_retention_days != null ? 1 : 0
  name              = "/aws/fsx/lustre/lustre-${var.fsx_id}"
  retention_in_days = 7
}

resource "aws_security_group" "fsx_sg" {
  name        = "fsx_lustre_sg_${var.fsx_id}"
  description = "Allow Lustre LNET traffic"
  vpc_id      = data.aws_subnet.selected.vpc_id

  ingress {
    description = "Allow Lustre LNET traffic"
    from_port   = 988
    to_port     = 988
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Or limit to your specific CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    TechNativeModule = "true"
    Name             = "fsx_lustre_sg-${var.fsx_id}"
  }
}

resource "aws_s3_bucket" "lustre_repository" {
  for_each = local.dra_config

  bucket        = each.value.bucket_name
  force_destroy = var.dra_bucket_force_destroy
}

resource "aws_s3_bucket_public_access_block" "lustre_repository" {
  for_each = aws_s3_bucket.lustre_repository

  bucket                  = each.value.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lustre_repository" {
  for_each = aws_s3_bucket.lustre_repository

  bucket = each.value.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_fsx_data_repository_association" "lustre_bucket" {
  for_each = local.dra_config

  file_system_id           = aws_fsx_lustre_file_system.hpc.id
  data_repository_path     = "s3://${aws_s3_bucket.lustre_repository[each.key].bucket}"
  file_system_path         = each.value.file_system_path
  imported_file_chunk_size = var.dra_imported_file_chunk_size
  batch_import_meta_data_on_create = true

  timeouts {
    create = "20m"
    delete = "20m"
  }

  s3 {
    auto_export_policy {
      events = each.value.auto_export_events
    }

    auto_import_policy {
      events = each.value.auto_import_events
    }
  }
}
