################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

terraform {
  backend "s3" {
  }
}

provider "aws" {
  version = "2.50.0"
  region  = var.region
}

provider "aws" {
  version = "2.50.0"
  alias   = "us-east-1"
  region  = "us-east-1"
}

provider "local" {
  version = "1.4.0"
}

provider "null" {
  version = "2.1.2"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.tfstate_bucket
    key    = var.vpc_tfstate_key
    region = var.region
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = var.tfstate_bucket
    key    = var.eks_tfstate_key
    region = var.region
  }
}

data "terraform_remote_state" "rds" {
  backend = "s3"

  config = {
    bucket = var.tfstate_bucket
    key    = var.rds_tfstate_key
    region = var.region
  }
}

provider "mysql" {
  version  = "1.9.0"
  endpoint = data.terraform_remote_state.rds.outputs.endpoint
  username = data.terraform_remote_state.rds.outputs.db_username
  password = data.terraform_remote_state.rds.outputs.db_password
}
