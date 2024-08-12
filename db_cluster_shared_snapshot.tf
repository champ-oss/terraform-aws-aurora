resource "aws_db_cluster_snapshot" "this" {
  count                          = var.enable_snapshot_account_share && var.enabled ? 1 : 0
  db_cluster_identifier          = aws_rds_cluster.this.id
  db_cluster_snapshot_identifier = var.db_cluster_snapshot_identifier
  shared_accounts                = var.shared_accounts_snapshot
  tags                           = merge(local.tags, var.tags)
}
