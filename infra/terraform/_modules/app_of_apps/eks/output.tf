output "efs_id" {
  value = aws_efs_file_system.prometheus.id
}

output "efs_access_point_id" {
  value = aws_efs_access_point.prometheus_data.id
}