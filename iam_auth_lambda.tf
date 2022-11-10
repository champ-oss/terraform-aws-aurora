resource "random_string" "identifier" {
  count   = var.iam_auth_lambda_enabled ? 1 : 0
  length  = 5
  special = false
  upper   = false
  lower   = true
  numeric = false
}

module "iam_auth_lambda" {
  source              = "github.com/champ-oss/terraform-aws-lambda.git?ref=v1.0.109-81e1d34"
  count               = var.iam_auth_lambda_enabled ? 1 : 0
  git                 = var.git
  name                = "${var.cluster_identifier_prefix}-iam-auth-${random_string.identifier[0].result}"
  tags                = merge(local.tags, var.tags)
  description         = "iam auth rds database lambda function"
  enable_cw_event     = true
  schedule_expression = "rate(1 hour)"
  enable_vpc          = true
  private_subnet_ids  = var.private_subnet_ids
  sync_image          = true
  sync_source_repo    = "champtitles/terraform-aws-mysql-iam-auth"
  ecr_name            = "${var.cluster_identifier_prefix}-iam-auth-${random_string.identifier[0].result}"
  ecr_tag             = var.iam_auth_docker_tag
  vpc_id              = var.vpc_id # eni delete resource bug https://github.com/hashicorp/terraform-provider-aws/issues/10329
  environment = {
    DB_HOST         = "${aws_rds_cluster.this.endpoint}:${aws_rds_cluster.this.port}"
    DB_USERNAME     = aws_rds_cluster.this.master_username
    SSM_NAME        = aws_ssm_parameter.this.name
    RO_USER_NAME    = var.mysql_iam_read_username
    ADMIN_USER_NAME = var.mysql_iam_admin_username
  }
}
