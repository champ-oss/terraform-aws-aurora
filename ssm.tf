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
    read_only_endpoint = aws_rds_cluster.this.reader_endpoint
  }, local.tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

module "dms_shared_ssm" {
  count                     = length(var.dms_shared_ssm_accounts) == 0 ? 0 : 1
  source                    = "github.com/champ-oss/terraform-aws-ssm.git?ref=v1.0.2-3054cc7"
  git                       = var.git
  enable_random_name_suffix = false
  enable_kms                = true
  name                      = "/${var.git}/dms/${aws_rds_cluster.this.cluster_identifier}/shared-ssm"
  value                     = random_password.password.result
  tags = merge({
    master_username    = aws_rds_cluster.this.master_username
    port               = aws_rds_cluster.this.port
    read_only_endpoint = aws_rds_cluster.this.reader_endpoint
  }, local.tags, var.tags)
  shared_accounts = var.dms_shared_ssm_accounts
}
