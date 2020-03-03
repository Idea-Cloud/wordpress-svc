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
