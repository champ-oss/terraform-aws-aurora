resource "aws_security_group" "rds" {
  name_prefix = "${var.cluster_identifier_prefix}-rds-"
  vpc_id      = var.vpc_id
  tags        = merge(local.tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "from_sg" {
  description              = "ingress from security group"
  type                     = "ingress"
  from_port                = aws_rds_cluster.this.port
  to_port                  = aws_rds_cluster.this.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = var.source_security_group_id
}

resource "aws_security_group_rule" "from_cidr" {
  description       = "ingress from cidr blocks"
  type              = "ingress"
  from_port         = aws_rds_cluster.this.port
  to_port           = aws_rds_cluster.this.port
  protocol          = "tcp"
  security_group_id = aws_security_group.rds.id
  cidr_blocks       = var.cidr_blocks
}

resource "aws_security_group" "glue" {
  count       = var.enable_glue_connection ? 1 : 0
  name_prefix = "${var.cluster_identifier_prefix}-glue-"
  vpc_id      = var.vpc_id
  tags        = merge(local.tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "glue" {
  count                    = var.enable_glue_connection ? 1 : 0
  description              = "ingress from security group"
  type                     = "ingress"
  from_port                = aws_rds_cluster.this.port
  to_port                  = aws_rds_cluster.this.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.glue[0].id
  source_security_group_id = var.source_security_group_id
}

resource "aws_security_group_rule" "glue_ingress_self" {
  count                    = var.enable_glue_connection ? 1 : 0
  description              = "ingress self reference"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.glue[0].id
  source_security_group_id = aws_security_group.glue[0].id
}

resource "aws_security_group_rule" "glue_egress_self" {
  count                    = var.enable_glue_connection ? 1 : 0
  description              = "egress self reference"
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.glue[0].id
  source_security_group_id = aws_security_group.glue[0].id
}

resource "aws_security_group_rule" "glue_egress_internet" {
  description       = "egress internet"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  security_group_id = aws_security_group.glue[0].id
  cidr_blocks       = ["0.0.0.0/0"]
}

