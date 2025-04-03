resource "aws_vpc_security_group_ingress_rule" "from_sg" {
  count                        = var.enabled && var.enable_source_security_group && !var.enabled_legacy_secruity_group_rule ? 1 : 0
  description                  = "ingress from security group"
  from_port                    = aws_rds_cluster.this[0].port
  to_port                      = aws_rds_cluster.this[0].port
  ip_protocol                  = "tcp"
  security_group_id            = aws_security_group.rds[0].id
  referenced_security_group_id = var.source_security_group_id
  tags                         = merge(local.tags, var.tags)
}

resource "aws_vpc_security_group_ingress_rule" "from_cidr" {
  count             = var.enabled && !var.enabled_legacy_secruity_group_rule ? 1 : 0
  description       = "ingress from cidr blocks"
  from_port         = aws_rds_cluster.this[0].port
  to_port           = aws_rds_cluster.this[0].port
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.rds[0].id
  tags              = merge(local.tags, var.tags)
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_self" {
  count                        = var.enabled && !var.enabled_legacy_secruity_group_rule ? 1 : 0
  description                  = "ingress self reference"
  from_port                    = 0
  to_port                      = 65535
  ip_protocol                  = "tcp"
  security_group_id            = aws_security_group.rds[0].id
  referenced_security_group_id = aws_security_group.rds[0].id
  tags                         = merge(local.tags, var.tags)
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  count             = var.enabled && !var.enabled_legacy_secruity_group_rule ? 1 : 0
  description       = "egress internet"
  from_port         = 0
  to_port           = 65535
  ip_protocol       = "all"
  security_group_id = aws_security_group.rds[0].id
  cidr_ipv4         = "0.0.0.0/0"
  tags              = merge(local.tags, var.tags)
}