resource "aws_ram_resource_share" "this" {
  count                     = length(var.shared_accounts) == 0 ? 0 : 1
  name                      = var.cluster_identifier_prefix
  allow_external_principals = var.allow_external_principals
  tags                      = merge(local.tags, var.tags)
}

resource "aws_ram_principal_association" "this" {
  for_each           = var.shared_accounts
  principal          = each.value
  resource_share_arn = aws_ram_resource_share.this.arn
}

resource "aws_ram_resource_association" "this" {
  count              = length(var.shared_accounts) == 0 ? 0 : 1
  resource_arn       = aws_rds_cluster.this.arn
  resource_share_arn = aws_ram_resource_share.this.arn
}