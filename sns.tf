resource "aws_sns_topic" "this" {
  count       = var.enabled ? 1 : 0
  name_prefix = "${var.cluster_identifier_prefix}-aurora-alarms-"
}

resource "aws_sns_topic_subscription" "this" {
  count      = var.enabled && var.alarms_email != null ? 1 : 0
  depends_on = [aws_sns_topic.this]
  topic_arn  = aws_sns_topic.this[0].arn
  protocol   = "email"
  endpoint   = var.alarms_email
}
