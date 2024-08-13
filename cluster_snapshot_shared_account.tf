resource "aws_db_cluster_snapshot" "this" {
  count                          = var.enable_db_cluster_snapshot_share && var.enabled ? 1 : 0
  db_cluster_identifier          = aws_rds_cluster.this[0].id
  db_cluster_snapshot_identifier = substr("${aws_rds_cluster.this[0].id}-shared", 0, 63)
  shared_accounts                = var.shared_accounts_snapshot
  tags                           = merge(local.tags, var.tags)
}

resource "aws_db_snapshot_copy" "this" {
  count                         = var.source_db_snapshot_identifier != null ? 1 : 0
  source_db_snapshot_identifier = var.source_db_snapshot_identifier
  target_db_snapshot_identifier = substr("${var.source_db_snapshot_identifier}-copy", 0, 63)
  tags                          = merge(local.tags, var.tags)
  kms_key_id                    = var.create_kms ? module.kms[0].key_id : null
}
