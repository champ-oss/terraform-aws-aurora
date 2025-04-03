terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.30.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

data "aws_vpcs" "this" {
  tags = {
    purpose = "vega"
  }
}

data "aws_subnets" "this" {
  tags = {
    purpose = "vega"
    Type    = "Private"
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.this.ids[0]]
  }
}

resource "random_id" "this" {
  byte_length = 3
}

resource "aws_security_group" "test" {
  name_prefix = "test-aurora-"
  vpc_id      = data.aws_vpcs.this.ids[0]
}

module "this" {
  source                          = "../../"
  cluster_identifier_prefix       = "terraform-aws-aurora-${random_id.this.hex}"
  private_subnet_ids              = data.aws_subnets.this.ids
  protect                         = false
  skip_final_snapshot             = true
  source_security_group_id        = aws_security_group.test.id
  vpc_id                          = data.aws_vpcs.this.ids[0]
  enable_secrets_manager          = true
  engine                          = "aurora-postgresql"
  engine_version                  = "16.6"
  enabled_cloudwatch_logs_exports = ["postgresql", "iam-db-auth-error"]
  performance_insights_enabled    = true
  enable_glue_connection          = true
  create_dms_endpoint             = true
  dms_endpoint_type               = "target"
  create_iam_role                 = true
  enable_secrets_manager          = true
}
