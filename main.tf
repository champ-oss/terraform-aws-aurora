locals {
  snapshot_timestamp = formatdate("'${var.cluster_identifier_prefix}-'YYYYMMDDHHmmss", timestamp())
  db_snapshot_source = var.db_snapshot_source_arn != null ? data.aws_db_snapshot.this[0].id : null

  tags = {
    cost    = "aurora"
    creator = "terraform"
    git     = var.git
  }

  default_kms_policy_actions = [
    "kms:CreateGrant",
    "kms:Decrypt",
    "kms:DescribeKey",
    "kms:Encrypt",
    "kms:GenerateDataKey*",
    "kms:ListGrants",
    "kms:ReEncrypt*",
    "kms:RetireGrant",
    "kms:RevokeGrant",
  ]
}