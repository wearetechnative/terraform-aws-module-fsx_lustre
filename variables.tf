variable "storage_capacity" {
    type = number
    description = "storage capacity of Lustre fs (amount of GB's)"  
}

variable "data_compression_type" {
  type = string
  description = "can be LZ4 or NONE"
}
  
variable "backup_retention_days" {
  type = number
  description = "Amount of days automatic backup retention"
  default = 0
}

variable "deployment_type" {
  type = string
  description = "deployment type can be: SCRATCH_1, SCRATCH_2, PERSISTENT_1, PERSISTENT_2."
}

variable "unit_storage_throughput" {
  type = string
  description = "Describes the amount of read and write throughput for each 1 tebibyte of storage, in MB/s/TiB, required for the PERSISTENT_1 and PERSISTENT_2 deployment_type"
  
}  

variable "subnet_ids" {
  type = list(string)
  description = "A list of IDs for the security groups that apply to the specified network interfaces created for file system access."
}  
variable "weekly_maintenance_start_time" {
  type = string
  description = "The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone."
}

variable "log_destination" {
    type = string
    description = "he Amazon Resource Name (ARN) that specifies the destination of the logs. The name of the Amazon CloudWatch Logs log group must begin with the /aws/fsx prefix"
  
}
variable "log_level" {
    type = string
    description = " Sets which data repository events are logged by Amazon FSx. Valid values are WARN_ONLY, FAILURE_ONLY, ERROR_ONLY, WARN_ERROR and DISABLED"
}
 

