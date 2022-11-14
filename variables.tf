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

variable "allow_major_version_upgrade" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#allow_major_version_upgrade"
  default     = false
  type        = bool
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

variable "create_dms_endpoint" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint"
  type        = bool
  default     = false
}

variable "create_dms_replication_task" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_task"
  type        = bool
  default     = false
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

variable "dms_endpoint_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint#endpoint_type"
  type        = string
  default     = "target"
}

variable "dms_migration_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_task#migration_type"
  type        = string
  default     = "full-load-and-cdc"
}

variable "dms_replication_instance_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_task#replication_instance_arn"
  type        = string
  default     = null
}

variable "dms_source_endpoint_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_task#source_endpoint_arn"
  type        = string
  default     = null
}

variable "dms_source_schema_name" {
  description = "Name of source schema"
  type        = string
  default     = "this"
}

variable "enable_global_write_forwarding" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#enable_global_write_forwarding"
  type        = string
  default     = null
}

variable "enable_http_endpoint" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#enable_http_endpoint"
  type        = bool
  default     = false
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
  default     = "8.0.mysql_aurora.3.02.1"
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

variable "iam_auth_docker_tag" {
  description = "Docker tag of IAM Auth code to deploy"
  type        = string
  default     = "a5f43f9c4ab5d1b0be4923f58bff799e53d38753"
}

variable "iam_auth_lambda_enabled" {
  description = "enable or disable the lambda for setting up iam auth"
  default     = false
  type        = bool
}

variable "iam_roles" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#iam_roles"
  type        = list(string)
  default     = null
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
  default     = 300 # in seconds
}

variable "metric_threshold_acu_utilization" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#threshold"
  type        = number
  default     = 75
}

variable "monitoring_interval" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#monitoring_interval"
  type        = number
  default     = 60
}

variable "mysql_iam_read_username" {
  description = "read only user to be created via lambda function"
  type        = string
  default     = "db_iam_read"
}

variable "mysql_iam_admin_username" {
  description = "admin user to be created via lambda function"
  type        = string
  default     = "db_iam_admin"
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
  default     = "Sun:07:00-Sun:08:00"
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

variable "replication_source_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#replication_source_identifier"
  type        = string
  default     = null
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

variable "source_region" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#source_region"
  type        = string
  default     = null
}

variable "source_security_group_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule#source_security_group_id"
  type        = string
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

variable "vpc_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  type        = string
}