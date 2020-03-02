################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

################################################################################
#
# GLOBAL
#
################################################################################
variable "region" {
  description = "region"
}

variable "environment" {
  description = "Environment"
}

################################################################################
#
# REMOTE STATE
#
################################################################################
variable "tfstate_bucket" {
  description = "Terraform state bucket"
}

variable "vpc_tfstate_key" {
  description = "VPC tfstate key"
}

variable "eks_tfstate_key" {
  description = "EKS tfstate key"
}

variable "rds_tfstate_key" {
  description = "RDS tfstate key"
}

################################################################################
#
# WORDPRESS
#
################################################################################

variable "wp_version" {
  type        = string
  description = "Wordpress image version"
}

variable "wp_debug" {
  type        = string
  description = "Activate debug mode"
}

variable "wp_domain_name" {
  type        = string
  description = "Domain name"
}
