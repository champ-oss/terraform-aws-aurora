terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.30.0"
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

resource "aws_security_group" "test" {
  name_prefix = "test-aurora-"
  vpc_id      = data.aws_vpcs.this.ids[0]
}

module "this" {
  source                    = "../../"
  cluster_identifier_prefix = "terraform-aws-aurora-mysql-test1-cluster"
  private_subnet_ids        = data.aws_subnets.this.ids
  protect                   = false
  skip_final_snapshot       = true
  source_security_group_id  = aws_security_group.test.id
  vpc_id                    = data.aws_vpcs.this.ids[0]
  enable_secrets_manager    = true
}
