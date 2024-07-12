module "s3" {
  count   = var.create_s3 ? 1 : 0
  source  = "github.com/champ-oss/terraform-aws-s3.git?ref=v1.0.49-2984d72"
  git     = substr(var.git, 0, 60)
  name    = local.cluster_identifier_prefix
  protect = var.protect
  tags    = merge(local.tags, var.tags)
  enabled = var.enabled
}