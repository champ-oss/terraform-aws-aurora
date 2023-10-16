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
  count              = var.create_iam_role ? 1 : 0
  name_prefix        = substr("${local.cluster_identifier_prefix}-", 0, 38)
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
  tags               = merge(local.tags, var.tags)
}

data "aws_iam_policy_document" "assume_role" {
  count = var.create_iam_role ? 1 : 0
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
  count      = var.create_iam_role ? 1 : 0
  policy_arn = aws_iam_policy.this[0].arn
  role       = aws_iam_role.this[0].name
}

resource "aws_iam_policy" "this" {
  count       = var.create_iam_role ? 1 : 0
  name_prefix = substr("${local.cluster_identifier_prefix}-", 0, 60)
  policy      = data.aws_iam_policy_document.this[0].json
}

data "aws_iam_policy_document" "this" {
  count = var.create_iam_role ? 1 : 0
  statement {
    actions   = ["iam:PassRole"]
    resources = ["*"]
  }

  statement {
    actions   = ["rds:StartExportTask"]
    resources = [aws_rds_cluster.this.arn]
  }

  statement {
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:Describe*",
      "kms:Generate*",
      "kms:Get*",
    ]
    resources = [module.kms[0].arn]
  }

  statement {
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${module.s3[0].bucket}",
      "arn:aws:s3:::${module.s3[0].bucket}/*"
    ]
  }
}