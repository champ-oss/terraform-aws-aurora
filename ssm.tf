resource "aws_ssm_parameter" "this" {
  name        = "/${var.git}/mysql/${aws_rds_cluster.this.cluster_identifier}/password"
  description = "mysql password"
  type        = "SecureString"
  value       = random_password.password.result
  tags = merge({
    master_username    = aws_rds_cluster.this.master_username
    port               = aws_rds_cluster.this.port
    endpoint           = aws_rds_cluster.this.endpoint
    cluster_identifier = aws_rds_cluster.this.cluster_identifier
  }, local.tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}
