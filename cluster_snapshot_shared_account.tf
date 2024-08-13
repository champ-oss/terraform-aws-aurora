resource "aws_db_cluster_snapshot" "this" {
  count                          = var.enable_db_cluster_snapshot && var.enabled ? 1 : 0
  db_cluster_identifier          = aws_rds_cluster.this[0].id
  db_cluster_snapshot_identifier = substr("${aws_rds_cluster.this[0].id}-snapshot", 0, 63)
  shared_accounts                = var.shared_accounts_snapshot
  tags                           = merge(local.tags, var.tags)
}

resource "aws_db_snapshot_copy" "this" {
  count                         = var.enable_db_cluster_snapshot && var.enabled ? 1 : 0
  source_db_snapshot_identifier = aws_db_cluster_snapshot.this[0].db_snapshot_arn
  target_db_snapshot_identifier = substr("${aws_db_cluster_snapshot.this[0].id}-copy", 0, 63)
  tags                          = merge(local.tags, var.tags)
  kms_key_id                    = create_kms ? module.kms[0].key_id : null
  depends_on = [aws_db_cluster_snapshot.this]
}
