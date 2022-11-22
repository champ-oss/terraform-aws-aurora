resource "random_password" "password" {
  length  = 32
  special = false

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_db_snapshot" "this" {
  count                  = var.db_snapshot_source_arn != null ? 1 : 0
  db_snapshot_identifier = var.db_snapshot_source_arn
  snapshot_type          = "manual"
}

resource "aws_db_subnet_group" "this" {
  name_prefix = "${var.cluster_identifier_prefix}-"
  subnet_ids  = var.private_subnet_ids
  tags        = merge(local.tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_rds_cluster" "this" {
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  apply_immediately                   = !var.protect
  availability_zones                  = var.availability_zones
  backtrack_window                    = var.backtrack_window
  backup_retention_period             = var.backup_retention_period
  cluster_identifier_prefix           = "${var.cluster_identifier_prefix}-"
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  database_name                       = var.database_name
  db_cluster_instance_class           = var.db_cluster_instance_class
  db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name
  db_instance_parameter_group_name    = var.db_instance_parameter_group_name
  db_subnet_group_name                = aws_db_subnet_group.this.id
  deletion_protection                 = var.protect
  enable_global_write_forwarding      = var.enable_global_write_forwarding
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  enable_http_endpoint                = var.enable_http_endpoint
  engine                              = var.engine
  engine_mode                         = var.engine_mode
  engine_version                      = var.engine_version
  final_snapshot_identifier           = var.final_snapshot_identifier != null ? var.final_snapshot_identifier : local.snapshot_timestamp
  global_cluster_identifier           = var.global_cluster_identifier
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  iam_roles                           = var.iam_roles
  iops                                = var.iops
  kms_key_id                          = var.create_kms ? module.kms[0].arn : var.kms_key_id
  master_username                     = var.master_username
  master_password                     = random_password.password.result
  network_type                        = var.network_type
  port                                = var.port
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window
  replication_source_identifier       = var.replication_source_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  snapshot_identifier                 = var.snapshot_identifier != null ? var.snapshot_identifier : local.db_snapshot_source
  source_region                       = var.source_region
  storage_type                        = var.storage_type
  storage_encrypted                   = var.storage_encrypted
  tags                                = merge(local.tags, var.tags)
  vpc_security_group_ids              = [aws_security_group.rds.id]

  serverlessv2_scaling_configuration {
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
  }

  lifecycle {
    ignore_changes = [
      availability_zones,
      final_snapshot_identifier,
    ]
    replace_triggered_by = [
      var.snapshot_identifier,
      local.db_snapshot_source
    ]
  }
}

resource "aws_rds_cluster_instance" "this" {
  count                                 = var.cluster_instance_count
  apply_immediately                     = !var.protect
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  cluster_identifier                    = aws_rds_cluster.this.id
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  engine                                = aws_rds_cluster.this.engine
  engine_version                        = aws_rds_cluster.this.engine_version
  identifier_prefix                     = "${var.cluster_identifier_prefix}-"
  instance_class                        = var.instance_class
  monitoring_role_arn                   = aws_iam_role.rds_enhanced_monitoring.arn
  monitoring_interval                   = var.monitoring_interval
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  promotion_tier                        = var.promotion_tier
  tags                                  = merge(local.tags, var.tags)
}
