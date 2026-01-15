variable "storage_capacity" {
  type        = number
  description = "storage capacity of Lustre fs (amount of MB's)"
}

variable "data_compression_type" {
  type        = string
  description = "can be LZ4 or NONE"
}

variable "backup_retention_days" {
  type        = number
  description = "Amount of days automatic backup retention"
  default     = 0
}

variable "deployment_type" {
  type        = string
  description = "deployment type can be: SCRATCH_1, SCRATCH_2, PERSISTENT_1, PERSISTENT_2."
}

variable "unit_storage_throughput" {
  type        = string
  description = "Describes the amount of read and write throughput for each 1 tebibyte of storage, in MB/s/TiB, required for the PERSISTENT_1 and PERSISTENT_2 deployment_type"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of IDs for the security groups that apply to the specified network interfaces created for file system access."
}

variable "weekly_maintenance_start_time" {
  type        = string
  description = "The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone."
  default     = "6:01:30"
}

variable "log_level" {
  type        = string
  description = "Sets which data repository events are logged by Amazon FSx. Valid values are WARN_ONLY, FAILURE_ONLY, ERROR_ONLY, WARN_ERROR and DISABLED"
  default     = "WARN_ERROR"
}

variable "log_retention_days" {
  type        = string
  description = ""
  default     = "7"
}

variable "fsx_id" {
  type        = string
  description = "fsx name/id"
  default     = ""
}

variable "dra_directories" {
  type = map(object({
    bucket_name      = string
    file_system_path = string
    auto_export_events = optional(list(string))
    auto_import_events = optional(list(string))
  }))
  description = "Map of data repository associations to create, keyed by an identifier. Each entry defines a bucket name, file system path, and optional auto import/export events."
  default     = {}
}

variable "dra_bucket_force_destroy" {
  type        = bool
  description = "Whether to force destroy the data repository buckets when deleting the stack."
  default     = false
}

variable "dra_imported_file_chunk_size" {
  type        = number
  description = "Size of chunks (in MiB) for files imported from the data repository."
  default     = 1024
}

