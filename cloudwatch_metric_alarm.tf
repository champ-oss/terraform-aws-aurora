resource "aws_cloudwatch_metric_alarm" "acu_utilization" {
  count               = var.metric_alarms_enabled ? 1 : 0
  alarm_name          = "${aws_rds_cluster.this.cluster_identifier}-ACUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.metric_evaluation_periods
  metric_name         = "ACUUtilization"
  namespace           = "AWS/RDS"
  period              = var.metric_period
  statistic           = "Average"
  threshold           = var.metric_threshold_acu_utilization
  alarm_actions       = [aws_sns_topic.this.arn]
  ok_actions          = [aws_sns_topic.this.arn]

  dimensions = {
    DBInstanceIdentifier = aws_rds_cluster.this.cluster_identifier
  }
  tags = merge(local.tags, var.tags)
}