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
  source                              = "../../"
  backup_retention_period             = 1
  cluster_identifier_prefix           = "terraform-aws-aurora-mysql-test1-cluster"
  cluster_instance_count              = 1
  iam_database_authentication_enabled = true
  private_subnet_ids                  = data.aws_subnets.this.ids
  protect                             = false
  skip_final_snapshot                 = true
  source_security_group_id            = aws_security_group.test.id
  vpc_id                              = data.aws_vpcs.this.ids[0]
  publicly_accessible                 = true
  create_dms_endpoint                 = true
  dms_endpoint_type                   = "source"
}