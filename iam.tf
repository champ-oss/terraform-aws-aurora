resource "aws_iam_role" "rds_enhanced_monitoring" {
  name_prefix        = "rds-enhanced-monitoring-"
  assume_role_policy = data.aws_iam_policy_document.rds_enhanced_monitoring.json
  tags               = merge(local.tags, var.tags)
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = aws_iam_role.rds_enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name_prefix        = "${var.git}-${local.cluster_identifier_prefix}-"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = merge(local.tags, var.tags)
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "scheduler.amazonaws.com",
        "rds.amazonaws.com",
        "export.rds.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}

resource "aws_iam_policy" "this" {
  name_prefix = var.git
  policy      = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "iam:PassRole",
      "rds:StartExportTask"
    ]
    resources = ["*"]
  }

  statement {
    actions   = ["kms:*"]
    resources = [module.kms[0].arn]
  }

  statement {
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::${module.s3.bucket}/*"]
  }
}