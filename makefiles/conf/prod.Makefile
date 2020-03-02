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
# NOTICE OF USAGE
# YOU ONLY NEED TO DEFINE VARS THAT SHOULD BE OVERRIDED FROM BASE.MAKEFILE
#
################################################################################

################################################################################
#
# AWS Configuration
#
################################################################################
AWS_ACCESS_KEY_ID           ?= "${PROD_AWS_ACCESS_KEY_ID}"
AWS_SECRET_ACCESS_KEY       ?= "${PROD_AWS_SECRET_ACCESS_KEY}"
AWS_DEFAULT_REGION          ?= "${PROD_AWS_DEFAULT_REGION}"

################################################################################
#
# TF State Configuration
#
################################################################################
TFSTATE_BUCKET              ?= "kjhsdfnbvuio-prod-tfstates"
TFSTATE_REGION              ?= "eu-west-3"

################################################################################
#
# Global Configuration
#
################################################################################
TFVARS_file                 ?= "variables.prod.tfvars"
ENVIRONMENT                 ?= "prod"

################################################################################
#
# Wordpress Configuration
#
################################################################################
WP_DEBUG                    ?= 0
WP_VERSION                  ?= "5.3.1-php7.4-apache"
WP_DOMAIN_NAME              ?= "exemple.com"
