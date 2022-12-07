resource "aws_dms_endpoint" "this" {
  depends_on    = [aws_rds_cluster_instance.this]
  count         = var.create_dms_endpoint ? 1 : 0
  endpoint_id   = "${aws_rds_cluster.this.cluster_identifier}-dms-endpoint"
  endpoint_type = var.dms_endpoint_type
  engine_name   = "aurora"
  database_name = var.database_name
  password      = random_password.password.result
  port          = aws_rds_cluster.this.port
  server_name   = aws_rds_cluster.this.endpoint
  tags          = merge(local.tags, var.tags)
  username      = aws_rds_cluster.this.master_username

  timeouts {
    create = "60m"
    delete = "60m"
  }
}

resource "aws_dms_replication_task" "this" {
  depends_on               = [aws_rds_cluster_instance.this]
  count                    = var.create_dms_replication_task ? 1 : 0
  migration_type           = var.dms_migration_type
  replication_instance_arn = var.dms_replication_instance_arn
  replication_task_id      = aws_rds_cluster.this.cluster_identifier
  replication_task_settings = jsonencode(
    {
      "Logging" : {
        "EnableLogging" : true,
        "LogComponents" : [
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "TRANSFORMATION"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "SOURCE_UNLOAD"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "IO"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "TARGET_LOAD"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "PERFORMANCE"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "SOURCE_CAPTURE"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "SORTER"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "REST_SERVER"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "VALIDATOR_EXT"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "TARGET_APPLY"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "TASK_MANAGER"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "TABLES_MANAGER"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "METADATA_MANAGER"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "FILE_FACTORY"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "COMMON"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "ADDONS"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "DATA_STRUCTURE"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "COMMUNICATION"
          },
          {
            "Severity" : "LOGGER_SEVERITY_DEFAULT",
            "Id" : "FILE_TRANSFER"
          }
        ],
      },
      "StreamBufferSettings" : {
        "StreamBufferCount" : 3,
        "CtrlStreamBufferSizeInMB" : 5,
        "StreamBufferSizeInMB" : 8
      },
      "ErrorBehavior" : {
        "FailOnNoTablesCaptured" : true,
        "ApplyErrorUpdatePolicy" : "LOG_ERROR",
        "FailOnTransactionConsistencyBreached" : false,
        "RecoverableErrorThrottlingMax" : 1800,
        "DataErrorEscalationPolicy" : "SUSPEND_TABLE",
        "ApplyErrorEscalationCount" : 0,
        "RecoverableErrorStopRetryAfterThrottlingMax" : true,
        "RecoverableErrorThrottling" : true,
        "ApplyErrorFailOnTruncationDdl" : false,
        "DataTruncationErrorPolicy" : "LOG_ERROR",
        "ApplyErrorInsertPolicy" : "LOG_ERROR",
        "EventErrorPolicy" : "IGNORE",
        "ApplyErrorEscalationPolicy" : "LOG_ERROR",
        "RecoverableErrorCount" : -1,
        "DataErrorEscalationCount" : 0,
        "TableErrorEscalationPolicy" : "STOP_TASK",
        "RecoverableErrorInterval" : 5,
        "ApplyErrorDeletePolicy" : "IGNORE_RECORD",
        "TableErrorEscalationCount" : 0,
        "FullLoadIgnoreConflicts" : true,
        "DataErrorPolicy" : "LOG_ERROR",
        "TableErrorPolicy" : "SUSPEND_TABLE"
      },
      "ValidationSettings" : {
        "ValidationPartialLobSize" : 0,
        "PartitionSize" : 10000,
        "RecordFailureDelayLimitInMinutes" : 0,
        "SkipLobColumns" : false,
        "FailureMaxCount" : 10000,
        "HandleCollationDiff" : false,
        "ValidationQueryCdcDelaySeconds" : 0,
        "ValidationMode" : "ROW_LEVEL",
        "TableFailureMaxCount" : var.dms_table_failure_max_count,
        "RecordFailureDelayInMinutes" : 5,
        "MaxKeyColumnSize" : 8096,
        "EnableValidation" : true,
        "ThreadCount" : 5,
        "RecordSuspendDelayInMinutes" : 30,
        "ValidationOnly" : false
      },
      "TTSettings" : {
        "TTS3Settings" : null,
        "TTRecordSettings" : null,
        "EnableTT" : false
      },
      "FullLoadSettings" : {
        "CommitRate" : 10000,
        "StopTaskCachedChangesApplied" : false,
        "StopTaskCachedChangesNotApplied" : false,
        "MaxFullLoadSubTasks" : 8,
        "TransactionConsistencyTimeout" : 600,
        "CreatePkAfterFullLoad" : false,
        "TargetTablePrepMode" : var.dms_target_table_prep_mode
      },
      "TargetMetadata" : {
        "ParallelApplyBufferSize" : 0,
        "ParallelApplyQueuesPerThread" : 0,
        "ParallelApplyThreads" : 0,
        "TargetSchema" : "",
        "InlineLobMaxSize" : 0,
        "ParallelLoadQueuesPerThread" : 0,
        "SupportLobs" : var.dms_full_lob_mode,
        "LobChunkSize" : 64,
        "TaskRecoveryTableEnabled" : false,
        "ParallelLoadThreads" : 0,
        "LobMaxSize" : 0,
        "BatchApplyEnabled" : false,
        "FullLobMode" : var.dms_full_lob_mode,
        "LimitedSizeLobMode" : false,
        "LoadMaxFileSize" : 0,
        "ParallelLoadBufferSize" : 0
      },
      "BeforeImageSettings" : null,
      "ControlTablesSettings" : {
        "HistoryTimeslotInMinutes" : 5,
        "StatusTableEnabled" : false,
        "SuspendedTablesTableEnabled" : false,
        "HistoryTableEnabled" : false,
        "ControlSchema" : "",
        "FullLoadExceptionTableEnabled" : false
      },
      "LoopbackPreventionSettings" : null,
      "CharacterSetSettings" : null,
      "FailTaskWhenCleanTaskResourceFailed" : false,
      "ChangeProcessingTuning" : {
        "StatementCacheSize" : 50,
        "CommitTimeout" : 1,
        "BatchApplyPreserveTransaction" : true,
        "BatchApplyTimeoutMin" : 1,
        "BatchSplitSize" : 0,
        "BatchApplyTimeoutMax" : 30,
        "MinTransactionSize" : 1000,
        "MemoryKeepTime" : 60,
        "BatchApplyMemoryLimit" : 500,
        "MemoryLimitTotal" : 1024
      },
      "ChangeProcessingDdlHandlingPolicy" : {
        "HandleSourceTableDropped" : true,
        "HandleSourceTableTruncated" : true,
        "HandleSourceTableAltered" : true
      },
      "PostProcessingRules" : null
    }
  )
  source_endpoint_arn    = var.dms_source_endpoint_arn
  start_replication_task = true
  table_mappings = jsonencode({
    "rules" : [
      {
        "rule-type" : "selection",
        "rule-id" : "1",
        "rule-name" : "1",
        "object-locator" : {
          "schema-name" : var.dms_source_schema_name,
          "table-name" : "%"
        },
        "rule-action" : "include",
        "filters" : []
      }
    ]
  })
  tags                = merge(local.tags, var.tags)
  target_endpoint_arn = aws_dms_endpoint.this[0].endpoint_arn
}