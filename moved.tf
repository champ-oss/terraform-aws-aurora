moved {
  from = aws_iam_role.rds_enhanced_monitoring
  to   = aws_iam_role.rds_enhanced_monitoring[0]
}

moved {
  from = aws_iam_role_policy_attachment.rds_enhanced_monitoring
  to   = aws_iam_role_policy_attachment.rds_enhanced_monitoring[0]
}

moved {
  from = data.aws_iam_policy_document.rds_enhanced_monitoring
  to   = data.aws_iam_policy_document.rds_enhanced_monitoring[0]
}

moved {
  from = aws_ram_resource_association.this
  to   = aws_ram_resource_association.this[0]
}

moved {
  from = aws_ram_resource_share.this
  to   = aws_ram_resource_share.this[0]
}

moved {
  from = aws_security_group.rds
  to   = aws_security_group.rds[0]
}

moved {
  from = aws_security_group_rule.from_sg
  to   = aws_security_group_rule.from_sg[0]
}

moved {
  from = aws_security_group_rule.from_cidr
  to   = aws_security_group_rule.from_cidr[0]
}

moved {
  from = aws_security_group_rule.ingress_self
  to   = aws_security_group_rule.ingress_self[0]
}

moved {
  from = aws_security_group_rule.egress
  to   = aws_security_group_rule.egress[0]
}

moved {
  from = aws_sns_topic.this
  to   = aws_sns_topic.this[0]
}

moved {
  from = aws_ssm_parameter.this
  to   = aws_ssm_parameter.this[0]
}
