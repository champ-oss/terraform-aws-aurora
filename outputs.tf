output "arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#arn"
  value       = aws_rds_cluster.this.arn
}

output "cluster_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#cluster_identifier"
  value       = aws_rds_cluster.this.cluster_identifier
}

output "cluster_resource_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#cluster_resource_id"
  value       = aws_rds_cluster.this.cluster_resource_id
}

output "cluster_members" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#cluster_members"
  value       = aws_rds_cluster.this.cluster_members
}

output "database_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#database_name"
  value       = aws_rds_cluster.this.database_name
}

output "endpoint" {
  depends_on  = [aws_rds_cluster_instance.this]
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#endpoint"
  value       = aws_rds_cluster.this.endpoint
}

output "kms_key_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#key_id"
  value       = var.create_kms ? module.kms[0].arn : var.kms_key_id
}

output "master_username" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#master_username"
  value       = aws_rds_cluster.this.master_username
}

output "master_password" {
  description = "https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password"
  value       = aws_rds_cluster.this.master_password
  sensitive   = true
}

output "password_ssm_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter#name"
  value       = aws_ssm_parameter.this.name
}

output "port" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#port"
  value       = aws_rds_cluster.this.port
}

output "reader_endpoint" {
  depends_on  = [aws_rds_cluster_instance.this]
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#reader_endpoint"
  value       = aws_rds_cluster.this.reader_endpoint
}

output "security_group_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#id"
  value       = aws_security_group.rds.id
}

output "glue_connection_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/glue_connection#arn"
  value       = var.enable_glue_connection ? aws_glue_connection.this[0].arn : null
}

output "glue_connection_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/glue_connection#id"
  value       = var.enable_glue_connection ? aws_glue_connection.this[0].id : null
}

output "dms_endpoint_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint"
  value       = var.create_dms_endpoint ? aws_dms_endpoint.this.endpoint_id : null
}

output "dms_endpoint_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint"
  value       = var.create_dms_endpoint ? aws_dms_endpoint.this.endpoint_arn : null
}

