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
# Dockerfile Configuration
#
################################################################################
TARGET_DOCKER_REGISTRY      ?= ideacloud.registry
TARGET_IMAGE_NAME           ?= ideacloud-terraform
DOCKER_TAG                  ?= $(shell git log --pretty=format:'%h' -n 1)
DOCKER_IMAGE_NAME           ?= ${TARGET_DOCKER_REGISTRY}/${TARGET_IMAGE_NAME}:1.0.0

################################################################################
#
# AWS Configuration
#
################################################################################
#AWS_ACCESS_KEY_ID           ?=
#AWS_SECRET_ACCESS_KEY       ?=
#AWS_DEFAULT_REGION          ?=

################################################################################
#
# TF State Configuration
#
################################################################################
#TFSTATE_BUCKET              ?=
#TFSTATE_REGION              ?=

VPC_TFSTATE_KEY             ?= "vpc.tfstate"
EKS_TFSTATE_KEY             ?= "eks.tfstate"
RDS_TFSTATE_KEY             ?= "rds.tfstate"
WP_TFSTATE_KEY              ?= "wp.tfstate"

################################################################################
#
# Global Configuration
#
################################################################################
#TFVARS_file                 ?=
#ENVIRONMENT                 ?=

KUBECONFIG                  ?= ${ROOT_DIR}/.config/config-${ENVIRONMENT}

################################################################################
#
# Wordpress Configuration
#
################################################################################
#WP_DEBUG                    ?=
#WP_VERSION                  ?=
#WP_DOMAIN_NAME              ?=
