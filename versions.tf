terraform {
  required_version = ">= 1.5.0"
  aws = {
    source  = "hashicorp/aws"
    version = ">= 5.40.0, <= 5.68.0"
  }
}
