variable "tags" {
  description = "Default tags."
  type = object({
    Project     = string
    Environment = string
  })
}

variable "volume_handle" {
  description = "Kubernetes persistent volume's volumeHandle value. It can be EFS filesystem id only or [FileSystemId]::[AccessPointId]."
  type        = string
}