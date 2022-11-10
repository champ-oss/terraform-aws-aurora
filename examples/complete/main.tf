provider "aws" {
  region = "eu-west-2"
}

data "aws_region" "current" {}

module "vpc" {
  source                   = "github.com/champ-oss/terraform-aws-vpc.git?ref=v1.0.39-9596bfc"
  git                      = var.git
  availability_zones_count = 2
  retention_in_days        = 1
}

resource "aws_security_group" "test" {
  name_prefix = "test-aurora-"
  vpc_id      = module.vpc.vpc_id
}

module "this" {
  source = "../../"

  backup_retention_period             = 1
  cluster_identifier_prefix           = var.git
  cluster_instance_count              = 3
  iam_database_authentication_enabled = true
  iam_auth_lambda_enabled             = true
  private_subnet_ids                  = module.vpc.private_subnets_ids
  protect                             = false
  skip_final_snapshot                 = true
  source_security_group_id            = aws_security_group.test.id
  vpc_id                              = module.vpc.vpc_id
}