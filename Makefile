################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

include ./makefiles/vars.Makefile
include ./makefiles/tools.Makefile
include ./makefiles/kubectl.Makefile
include ./makefiles/docker.Makefile

# ENV from cli/makefile inject in docker
LOCAL_ENV := "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} TARGET_ENV=${TARGET_ENV} AUTO_APPROVE=${AUTO_APPROVE} WP_DEBUG=${WP_DEBUG} WP_DOMAIN_NAME=${WP_DOMAIN_NAME} WP_VERSION=${WP_VERSION}"

plan:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=_plan

_plan:
	@echo "############## RDS ##############"
	@cd rds && make init && make plan
	@echo "############## WORDPRESS ##############"
	@cd wordpress && make init && make plan

apply:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=_apply

_apply:
	@echo "############## RDS ##############"
	@cd rds && make init && make apply
	@echo "############## WORDPRESS ##############"
	@cd wordpress && make init && make apply
	@echo "############## kube svc ##############"
	@make kube args="get svc"
	@echo "############## kube nodes / pods ##############"
	@make kube args="get nodes"
	@make kube args="get pods --all-namespaces"

destroy:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=_destroy

_destroy:
	@echo "############## WORDPRESS ##############"
	@cd wordpress && make init && make destroy
	@echo "############## RDS ##############"
	@cd rds && make init && make destroy

import-state-%: # make import-state-state-bucket args='aws_s3_bucket.terraform_state kjhsdfnbvuio-prod-tfstates'
	@echo "############## IMPORT STATE ##############"
	@cd ${*} && make init && make import-state args="${args}"

format:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=_format

_format:
	@echo "############## RDS ##############"
	@cd rds && make format
	@echo "############## WORDPRESS ##############"
	@cd wordpress && make format

update-version:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=kube args="set image deployment/wordpress wordpress:${args}"

getsvc:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=kube args="get svc"

getpods:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=kube args="get pods --all-namespaces"

getlog-%:
#	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=kube args="edit svc/${*}"
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=kube args="logs -f ${*} --all-containers=true"

killpod-%:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=kube args="delete pod ${*}"
