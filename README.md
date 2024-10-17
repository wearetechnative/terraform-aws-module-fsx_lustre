# Terraform AWS [terraform-aws-module-fsx_lustre] ![](https://img.shields.io/github/workflow/status/TechNative-B-V/terraform-aws-module-fsx_lustre/tflint.yaml?style=plastic)

<!-- SHIELDS -->

This module implements ...

[![](we-are-technative.png)](https://www.technative.nl)

## How does it work

### First use after you clone this repository or when .pre-commit-config.yaml is updated

Run `pre-commit install` to install any guardrails implemented using pre-commit.

See [pre-commit installation](https://pre-commit.com/#install) on how to install pre-commit.

...

## Usage

To use this module ...

```hcl
{
  some_conf = "might need explanation"
}
```

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
| [aws_fsx_lustre_file_system.hpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_lustre_file_system) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Amount of days automatic backup retention | `number` | `0` | no |
| <a name="input_data_compression_type"></a> [data\_compression\_type](#input\_data\_compression\_type) | can be LZ4 or NONE | `string` | n/a | yes |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | deployment type can be: SCRATCH\_1, SCRATCH\_2, PERSISTENT\_1, PERSISTENT\_2. | `string` | n/a | yes |
| <a name="input_fsx_id"></a> [fsx\_id](#input\_fsx\_id) | fsx name/id | `string` | `""` | no |
| <a name="input_log_destination"></a> [log\_destination](#input\_log\_destination) | he Amazon Resource Name (ARN) that specifies the destination of the logs. The name of the Amazon CloudWatch Logs log group must begin with the /aws/fsx prefix | `string` | n/a | yes |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Sets which data repository events are logged by Amazon FSx. Valid values are WARN\_ONLY, FAILURE\_ONLY, ERROR\_ONLY, WARN\_ERROR and DISABLED | `string` | n/a | yes |
| <a name="input_storage_capacity"></a> [storage\_capacity](#input\_storage\_capacity) | storage capacity of Lustre fs (amount of MB's) | `number` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of IDs for the security groups that apply to the specified network interfaces created for file system access. | `list(string)` | n/a | yes |
| <a name="input_unit_storage_throughput"></a> [unit\_storage\_throughput](#input\_unit\_storage\_throughput) | Describes the amount of read and write throughput for each 1 tebibyte of storage, in MB/s/TiB, required for the PERSISTENT\_1 and PERSISTENT\_2 deployment\_type | `string` | n/a | yes |
| <a name="input_weekly_maintenance_start_time"></a> [weekly\_maintenance\_start\_time](#input\_weekly\_maintenance\_start\_time) | The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lustre_arn"></a> [lustre\_arn](#output\_lustre\_arn) | n/a |
| <a name="output_lustre_dns_name"></a> [lustre\_dns\_name](#output\_lustre\_dns\_name) | n/a |
<!-- END_TF_DOCS -->
