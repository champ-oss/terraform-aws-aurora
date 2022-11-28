module "kms" {
  count                   = var.create_kms ? 1 : 0
  source                  = "github.com/champ-oss/terraform-aws-kms.git?ref=v1.0.30-44f94bf"
  git                     = var.git
  name                    = "alias/${var.cluster_identifier_prefix}"
  deletion_window_in_days = var.deletion_window_in_days
  account_actions         = [for account in var.shared_accounts : { account = account, actions = local.default_kms_policy_actions }]
  tags                    = merge(local.tags, var.tags)
}