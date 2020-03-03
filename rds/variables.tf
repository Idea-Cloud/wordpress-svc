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

################################################################################
#
# RDS
#
################################################################################
variable "db_allocated_storage" {
  default = 10
}

variable "max_allocated_storage" {
  default = 100
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_username" {
  default = "test"
}

variable "db_password" {
  description = "DB pwd"
}
