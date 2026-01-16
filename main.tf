locals {
  snapshot_timestamp = formatdate("'${var.cluster_identifier_prefix}-'YYYYMMDDHHmmss", timestamp())

  # 60 character max length with 27 character random suffix
  cluster_identifier_prefix = trimsuffix(substr(var.cluster_identifier_prefix, 0, 33), "-")

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