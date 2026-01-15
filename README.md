# Terraform AWS [terraform-aws-module-fsx_lustre] ![](https://img.shields.io/github/actions/workflow/status/wearetechnative/terraform-aws-module-fsx_lustre/tflint.yaml?style=plastic)

<!-- SHIELDS -->

This module implements ...

[![](we-are-technative.png)](https://www.technative.nl)

## How does it work

### First use after you clone this repository or when .pre-commit-config.yaml is updated

Run `pre-commit install` to install any guardrails implemented using pre-commit.

See [pre-commit installation](https://pre-commit.com/#install) on how to install pre-commit.

...

## Usage

1. Configure the AWS provider in your root module (not shown below).
2. Add a module block that points to this repository and supply the required variables for capacity, throughput, networking and logging.
3. (Optional) Enable the data repository association (DRA) if you need to sync data to an S3 bucket.

### Minimal example

```hcl
module "fsx_lustre" {
  source = "git::https://github.com/wearetechnative/terraform-aws-fsx_lustre.git?ref=main"

  fsx_id                    = "hpc-fsx"
  storage_capacity          = 1200                # In MB
  data_compression_type     = "LZ4"
  deployment_type           = "PERSISTENT_2"
  unit_storage_throughput   = 125                 # MB/s per TiB
  subnet_ids                = ["subnet-0123456789abcdef0"]
  weekly_maintenance_start_time = "6:01:30"
  log_level                 = "WARN_ERROR"
  log_retention_days        = 7
}
```

### Enabling the optional data repository association

```hcl
module "fsx_lustre" {
  source = "git::https://github.com/wearetechnative/terraform-aws-fsx_lustre.git?ref=main"
  # ...same required arguments as above...

  create_dra               = true
  dra_bucket_name          = "my-lustre-data-repository"
  dra_bucket_force_destroy = true
  dra_auto_import_events   = ["NEW", "CHANGED"]
  dra_auto_export_events   = ["NEW", "CHANGED", "DELETED"]
}
```

### Creating multiple data repository associations

```hcl
module "fsx_lustre" {
  source = "git::https://github.com/wearetechnative/terraform-aws-fsx_lustre.git?ref=main"
  # ...same required arguments as above...

  dra_directories = {
    logs = {
      bucket_name      = "my-lustre-logs"
      file_system_path = "/logs"
    }
    data = {
      bucket_name      = "my-lustre-data"
      file_system_path = "/data"
    }
  }
}
```

When `dra_directories` is set, the single DRA inputs (`create_dra` and `dra_bucket_name`) are ignored.

The module exports identifiers and connection details for the created FSx for Lustre file system and, when enabled, the associated S3 data repository. Those outputs can be referenced in other parts of your configuration (see [Outputs](#outputs) below).

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lustre](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_fsx_data_repository_association.lustre_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_data_repository_association) | resource |
| [aws_fsx_lustre_file_system.hpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_lustre_file_system) | resource |
| [aws_s3_bucket.lustre_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.lustre_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.lustre_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_security_group.fsx_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Amount of days automatic backup retention | `number` | `0` | no |
| <a name="input_create_dra"></a> [create\_dra](#input\_create\_dra) | Whether to create a single FSx data repository association backed by an S3 bucket. | `bool` | `false` | no |
| <a name="input_data_compression_type"></a> [data\_compression\_type](#input\_data\_compression\_type) | can be LZ4 or NONE | `string` | n/a | yes |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | deployment type can be: SCRATCH\_1, SCRATCH\_2, PERSISTENT\_1, PERSISTENT\_2. | `string` | n/a | yes |
| <a name="input_dra_auto_export_events"></a> [dra\_auto_export_events](#input\_dra_auto_export_events) | FSx auto export event types to propagate from Lustre to S3. | `list(string)` | `["NEW","CHANGED","DELETED"]` | no |
| <a name="input_dra_auto_import_events"></a> [dra\_auto_import_events](#input\_dra_auto_import_events) | FSx auto import event types to propagate from S3 to Lustre. | `list(string)` | `["NEW","CHANGED","DELETED"]` | no |
| <a name="input_dra_bucket_force_destroy"></a> [dra\_bucket_force_destroy](#input\_dra_bucket_force_destroy) | Whether to force destroy the data repository bucket when deleting the stack. | `bool` | `false` | no |
| <a name="input_dra_bucket_name"></a> [dra\_bucket_name](#input\_dra_bucket_name) | Name of the S3 bucket to create for the single data repository association. Required when create\_dra is true. | `string` | `null` | no |
| <a name="input_dra_directories"></a> [dra\_directories](#input\_dra_directories) | Map of data repository associations to create, keyed by an identifier. Each entry defines a bucket name and file system path. | `map(object({ bucket_name = string, file_system_path = string }))` | `{}` | no |
| <a name="input_dra_imported_file_chunk_size"></a> [dra\_imported_file_chunk_size](#input\_dra_imported_file_chunk_size) | Size of chunks (in MiB) for files imported from the data repository. | `number` | `1024` | no |
| <a name="input_fsx_id"></a> [fsx\_id](#input\_fsx\_id) | fsx name/id | `string` | `""` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Sets which data repository events are logged by Amazon FSx. Valid values are WARN\_ONLY, FAILURE\_ONLY, ERROR\_ONLY, WARN\_ERROR and DISABLED | `string` | n/a | yes |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | n/a | `string` | `"7"` | no |
| <a name="input_storage_capacity"></a> [storage\_capacity](#input\_storage\_capacity) | storage capacity of Lustre fs (amount of MB's) | `number` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of IDs for the security groups that apply to the specified network interfaces created for file system access. | `list(string)` | n/a | yes |
| <a name="input_unit_storage_throughput"></a> [unit\_storage\_throughput](#input\_unit\_storage\_throughput) | Describes the amount of read and write throughput for each 1 tebibyte of storage, in MB/s/TiB, required for the PERSISTENT\_1 and PERSISTENT\_2 deployment\_type | `string` | n/a | yes |
| <a name="input_weekly_maintenance_start_time"></a> [weekly\_maintenance\_start\_time](#input\_weekly\_maintenance\_start\_time) | The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lustre_arn"></a> [lustre\_arn](#output\_lustre\_arn) | ARN of the FSx-Lustre |
| <a name="output_lustre_dns_name"></a> [lustre\_dns\_name](#output\_lustre\_dns\_name) | DNS name of the FSx-Lustre |
| <a name="output_data_repository_bucket_name"></a> [data\_repository\_bucket\_name](#output\_data_repository_bucket_name) | Name of the S3 bucket created for the data repository association (if enabled). |
| <a name="output_data_repository_association_id"></a> [data\_repository\_association\_id](#output\_data_repository_association_id) | ID of the data repository association (if enabled). |
| <a name="output_data_repository_bucket_names"></a> [data\_repository\_bucket\_names](#output\_data_repository_bucket_names) | Map of data repository bucket names keyed by the association identifier. |
| <a name="output_data_repository_association_ids"></a> [data\_repository\_association\_ids](#output\_data_repository_association_ids) | Map of data repository association IDs keyed by the association identifier. |
| <a name="output_lustre_securitygroup_id"></a> [lustre\_securitygroup\_id](#output\_lustre\_securitygroup\_id) | ID of the security\_group created for the FSx-Lustre |
<!-- END_TF_DOCS -->
