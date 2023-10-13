module "s3" {
  source  = "github.com/champ-oss/terraform-aws-s3.git?ref=v1.0.45-e99f267"
  git     = substr(var.git, 0, 60)
  name    = local.cluster_identifier_prefix
  protect = var.protect
  tags    = merge(local.tags, var.tags)
}