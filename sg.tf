resource "aws_security_group" "this" {
  count       = var.enable_glue_connection ? 1 : 0
  description = "security group for glue"
  name        = aws_rds_cluster.this.cluster_identifier
  vpc_id      = var.vpc_id

  ingress {
    from_port   = aws_rds_cluster.this.port
    to_port     = aws_rds_cluster.this.port
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }
  tags = merge(local.tags, var.tags)
}