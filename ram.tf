resource "aws_ram_resource_share" "this" {
  count                     = var.enabled && length(var.shared_accounts) > 0 ? 1 : 0
  name                      = var.cluster_identifier_prefix
  allow_external_principals = var.allow_external_principals
  tags                      = merge(local.tags, var.tags)
}

resource "aws_ram_principal_association" "this" {
  for_each           = var.enabled ? toset(var.shared_accounts) : []
  principal          = each.value
  resource_share_arn = aws_ram_resource_share.this[0].arn
}

resource "aws_ram_resource_association" "this" {
  count              = var.enabled && length(var.shared_accounts) > 0 ? 1 : 0
  resource_arn       = aws_rds_cluster.this[0].arn
  resource_share_arn = aws_ram_resource_share.this[0].arn
}


