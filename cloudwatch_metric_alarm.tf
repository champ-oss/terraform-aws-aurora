resource "aws_cloudwatch_metric_alarm" "this" {
  count               = var.enabled && var.metric_alarms_enabled ? 1 : 0
  alarm_name          = "${aws_rds_cluster.this[0].cluster_identifier}-${var.metric_name}"
  comparison_operator = var.metric_comparison_operator
  evaluation_periods  = var.metric_evaluation_periods
  metric_name         = var.metric_name
  namespace           = "AWS/RDS"
  period              = var.metric_period
  statistic           = var.metric_statistic
  threshold           = var.metric_threshold
  alarm_actions       = [aws_sns_topic.this[0].arn]
  ok_actions          = var.metric_ok_actions_enabled ? [aws_sns_topic.this[0].arn] : []
  treat_missing_data  = var.metric_treat_missing_data
  tags                = merge(local.tags, var.tags)

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.this[0].cluster_identifier
  }
}
