variable "alarms_email" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription#endpoint"
  type        = string
  default     = null
}

variable "availability_zones" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#availability_zones"
  type        = list(string)
  default     = null
}

variable "allow_external_principals" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share#allow_external_principals"
  type        = bool
  default     = false
}

variable "allow_major_version_upgrade" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#allow_major_version_upgrade"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#auto_minor_version_upgrade"
  type        = bool
  default     = true
}

variable "backtrack_window" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#backtrack_window"
  type        = number
  default     = null
}

variable "backup_retention_period" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#backup_retention_period"
  type        = number
  default     = 35
}

variable "cidr_blocks" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule#cidr_blocks"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "cluster_identifier_prefix" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#cluster_identifier_prefix"
  type        = string
  default     = "mysqldb-test"
}

variable "cluster_instance_count" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance"
  type        = number
  default     = 1
}

variable "copy_tags_to_snapshot" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#copy_tags_to_snapshot"
  type        = bool
  default     = true
}

variable "create_kms" {
  description = "Create a KMS key for the database cluster"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#database_name"
  type        = string
  default     = "this"
}

variable "db_cluster_instance_class" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#db_cluster_instance_class"
  type        = string
  default     = null
}

variable "db_cluster_parameter_group_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#db_cluster_parameter_group_name"
  type        = string
  default     = null
}

variable "db_instance_parameter_group_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#db_instance_parameter_group_name"
  type        = string
  default     = null
}

variable "db_snapshot_source_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_snapshot#db_instance_identifier"
  type        = string
  default     = null
}

variable "deletion_window_in_days" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#deletion_window_in_days"
  type        = number
  default     = 30
}

variable "enable_global_write_forwarding" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#enable_global_write_forwarding"
  type        = string
  default     = null
}

variable "enable_http_endpoint" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#enable_http_endpoint"
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#enabled_cloudwatch_logs_exports"
  type        = list(string)
  default = [
    "audit",
    "error",
    "general",
    "slowquery"
  ]
}

variable "engine" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#engine"
  default     = "aurora-mysql"
  type        = string
}

variable "engine_mode" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#engine_mode"
  default     = "provisioned"
  type        = string
}

variable "engine_version" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#engine_version"
  type        = string
  default     = "8.0.mysql_aurora.3.07.1"
}

variable "final_snapshot_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#final_snapshot_identifier"
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#iam_database_authentication_enabled"
  default     = true
  type        = bool
}

variable "iam_roles" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#iam_roles"
  type        = list(string)
  default     = []
}

variable "instance_class" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#instance_class"
  type        = string
  default     = "db.serverless"
}

variable "kms_key_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#kms_key_id"
  type        = string
  default     = null
}

variable "git" {
  description = "Name of the Git repo"
  type        = string
  default     = "terraform-aws-aurora"
}

variable "global_cluster_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#global_cluster_identifier"
  type        = string
  default     = null
}

variable "iops" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#iops"
  type        = string
  default     = null
}

variable "master_username" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#master_username"
  type        = string
  default     = "root"
}

variable "min_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#min_capacity"
  type        = number
  default     = 0.5
}

variable "max_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#max_capacity"
  type        = number
  default     = 8 # each ACU corresponds to approximately 2 GiB of memory
}

variable "metric_alarms_enabled" {
  description = "enable or disable cloudwatch metric alarms"
  type        = bool
  default     = false
}

variable "metric_evaluation_periods" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#evaluation_periods"
  type        = number
  default     = 1
}

variable "metric_period" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#period"
  type        = number
  default     = 86400 # in seconds
}

variable "metric_threshold" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#threshold"
  type        = number
  default     = 115
}

variable "metric_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#metric_name"
  type        = string
  default     = "ServerlessDatabaseCapacity"
}

variable "metric_statistic" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#statistic"
  type        = string
  default     = "Maximum"
}

variable "metric_comparison_operator" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#comparison_operator"
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "metric_treat_missing_data" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#treat_missing_data"
  type        = string
  default     = "notBreaching"
}

variable "metric_ok_actions_enabled" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#ok_actions"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#monitoring_interval"
  type        = number
  default     = 60
}

variable "network_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#network_type"
  type        = string
  default     = null
}

variable "port" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#port"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#performance_insights_enabled"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#performance_insights_retention_period"
  type        = number
  default     = null
}

variable "preferred_backup_window" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#preferred_backup_window"
  type        = string
  default     = "06:00-06:30"
}

variable "preferred_maintenance_window" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#preferred_maintenance_window"
  default     = "sun:07:00-Sun:07:30"
  type        = string
}

variable "private_subnet_ids" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group#subnet_ids"
  type        = list(string)
}

variable "protect" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#deletion_protection"
  default     = true
  type        = bool
}

variable "promotion_tier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#promotion_tier"
  type        = number
  default     = 2
}

variable "publicly_accessible" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#publicly_accessible"
  type        = bool
  default     = false
}

variable "replication_source_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#replication_source_identifier"
  type        = string
  default     = null
}

variable "restore_to_time" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#restore_to_time"
  type        = string
  default     = null
}

variable "restore_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#restore_type"
  type        = string
  default     = "copy-on-write"
}

variable "shared_accounts" {
  description = "AWS accounts to share the RDS cluster"
  type        = list(string)
  default     = []
}

variable "skip_final_snapshot" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#skip_final_snapshot"
  default     = false
  type        = bool
}

variable "snapshot_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#snapshot_identifier"
  type        = string
  default     = null
}

variable "source_cluster_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#source_cluster_identifier"
  type        = string
  default     = null
}

variable "source_region" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#source_region"
  type        = string
  default     = null
}

variable "source_security_group_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule#source_security_group_id"
  type        = string
  default     = ""
}

variable "storage_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#storage_type"
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#storage_encrypted"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "use_latest_restorable_time" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#use_latest_restorable_time"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  type        = string
}

variable "enable_glue_connection" {
  description = "enable glue connection for rds"
  type        = bool
  default     = false
}

variable "create_dms_endpoint" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint"
  type        = bool
  default     = false
}

variable "dms_endpoint_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint#endpoint_type"
  type        = string
  default     = "target"
}

variable "dms_engine_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint#engine_name"
  type        = string
  default     = "aurora"
}

variable "dms_endpoint_read_only" {
  description = "Use reader database endpoint for DMS"
  type        = bool
  default     = false
}

variable "create_iam_role" {
  description = "Create an IAM role and attach to the RDS cluster"
  type        = bool
  default     = false
}

variable "create_s3" {
  description = "Create an S3 bucket"
  type        = bool
  default     = false
}

variable "enable_s3_export" {
  description = "https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/export-cluster-data.html"
  type        = bool
  default     = false
}

variable "s3_export_schedule_expression" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule#schedule_expression"
  type        = string
  default     = "cron(0 5 * * ? *)"
}

variable "s3_export_maximum_window_in_minutes" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule#flexible_time_window"
  type        = number
  default     = 15
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  type        = bool
  default     = true
}

variable "enable_source_security_group" {
  description = "Enable source security group"
  type        = bool
  default     = true
}

variable "enable_shared_snapshot" {
  description = "Enable snapshot account share"
  type        = bool
  default     = false
}

variable "shared_accounts_snapshot" {
  description = "AWS accounts to share the RDS cluster snapshot"
  type        = list(string)
  default     = []
}

variable "db_cluster_snapshot_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_snapshot#db_cluster_snapshot_identifier"
  type        = string
  default     = null
}

variable "enable_secrets_manager" {
  description = "Enable AWS Secrets Manager"
  type        = bool
  default     = false
}

variable "enable_backup" {
  description = "Enable AWS Backup"
  type        = bool
  default     = false
}

variable "enable_continuous_backup" {
  description = "Enable continuous backup of the S3 bucket"
  type        = bool
  default     = null
}

variable "backup_delete_after" {
  description = "Specifies the number of days after creation that backups are deleted"
  type        = number
  default     = 30
}

variable "backup_schedule" {
  description = "Specifies the schedule for creating backups"
  type        = string
  default     = "cron(0 6 * * ? *)"
}
