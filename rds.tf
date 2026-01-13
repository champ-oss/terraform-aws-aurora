locals {
  normalized_snapshot_identifier = (
    can(startswith(var.snapshot_identifier, "arn:"))
    ? var.snapshot_identifier
    : null
  )
}


resource "random_password" "password" {
  count   = var.enabled ? 1 : 0
  length  = 32
  special = false

  lifecycle {
    create_before_destroy = true
  }
}

moved {
  from = random_password.password
  to   = random_password.password[0]
}

resource "aws_db_subnet_group" "this" {
  count       = var.enabled ? 1 : 0
  name_prefix = "${var.cluster_identifier_prefix}-"
  subnet_ids  = var.private_subnet_ids
  tags        = merge(local.tags, var.tags)

  lifecycle {
    ignore_changes = [name_prefix]
  }
}

moved {
  from = aws_db_subnet_group.this
  to   = aws_db_subnet_group.this[0]
}

resource "aws_rds_cluster" "this" {
  count                               = var.enabled ? 1 : 0
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  apply_immediately                   = !var.protect
  availability_zones                  = var.availability_zones
  backtrack_window                    = var.backtrack_window
  backup_retention_period             = var.backup_retention_period
  cluster_identifier_prefix           = "${local.cluster_identifier_prefix}-"
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  database_name                       = var.database_name
  db_cluster_instance_class           = var.db_cluster_instance_class
  db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name
  db_instance_parameter_group_name    = var.db_instance_parameter_group_name
  db_subnet_group_name                = aws_db_subnet_group.this[0].id
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
  iam_roles                           = var.create_iam_role ? concat([aws_iam_role.this[0].arn], var.iam_roles) : var.iam_roles
  iops                                = var.iops
  kms_key_id                          = var.create_kms ? module.kms[0].arn : var.kms_key_id
  master_username                     = var.master_username
  master_password                     = random_password.password[0].result
  network_type                        = var.network_type
  port                                = var.port
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window
  replication_source_identifier       = var.replication_source_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  snapshot_identifier                 = local.normalized_snapshot_identifier
  source_region                       = var.source_region
  storage_type                        = var.storage_type
  storage_encrypted                   = var.storage_encrypted
  tags                                = merge(local.tags, var.tags)
  vpc_security_group_ids              = [aws_security_group.rds[0].id]

  serverlessv2_scaling_configuration {
    max_capacity             = var.max_capacity # increment must be equal to 0.5
    min_capacity             = var.min_capacity # increment must be equal to 0.5.
    seconds_until_auto_pause = var.min_capacity != 0 ? null : var.seconds_until_auto_pause
  }

  # tflint-ignore: terraform_comment_syntax
  //noinspection ConflictingProperties
  dynamic "restore_to_point_in_time" {
    for_each = var.source_cluster_identifier != null ? [1] : []
    content {
      restore_to_time            = var.restore_to_time
      restore_type               = var.restore_type
      source_cluster_identifier  = var.source_cluster_identifier
      use_latest_restorable_time = var.use_latest_restorable_time
    }
  }

  lifecycle {
    prevent_destroy = true

    precondition {
      condition = (
        var.snapshot_identifier == null ||
        var.snapshot_identifier == "" ||
        can(startswith(var.snapshot_identifier, "arn:"))
      )
      error_message = <<EOT
snapshot_identifier must be null, empty, or a valid snapshot ARN.
- Leave it null or empty to create a new database.
- Provide a snapshot ARN to restore.
EOT
    }

    ignore_changes = [
      availability_zones,
      final_snapshot_identifier,
      engine_version,
      cluster_identifier_prefix
    ]
  }
}

moved {
  from = aws_rds_cluster.this
  to   = aws_rds_cluster.this[0]
}

resource "aws_rds_cluster_instance" "this" {
  count                                 = var.enabled ? var.cluster_instance_count : 0
  apply_immediately                     = !var.protect
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  cluster_identifier                    = aws_rds_cluster.this[0].id
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  engine                                = aws_rds_cluster.this[0].engine
  engine_version                        = aws_rds_cluster.this[0].engine_version
  identifier_prefix                     = "${local.cluster_identifier_prefix}-"
  instance_class                        = var.instance_class
  monitoring_role_arn                   = aws_iam_role.rds_enhanced_monitoring[0].arn
  monitoring_interval                   = var.monitoring_interval
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  promotion_tier                        = var.promotion_tier
  publicly_accessible                   = var.publicly_accessible
  preferred_maintenance_window          = var.preferred_maintenance_window
  tags                                  = merge(local.tags, var.tags)
  lifecycle {
    ignore_changes = [
      engine_version,
      identifier_prefix
    ]
  }
}

moved {
  from = aws_rds_cluster_instance.this
  to   = aws_rds_cluster_instance.this[0]
}
