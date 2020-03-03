################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

init:
#	@rm -fR .terraform 2> /dev/null || echo > /dev/null
ifdef WITHOUT_BACKEND
	@${TERRAFORM_CMD} init --upgrade -backend=false -force-copy -input=false
else
	@${TERRAFORM_CMD} init --upgrade -backend-config="bucket=${TFSTATE_BUCKET}" \
	-backend-config="key=${TFSTATE_KEY}" -backend-config="region=${TFSTATE_REGION}" \
	-backend=true -force-copy -get=true -input=false
endif

_plan:
	@# Sometimes you can/may add --refresh=false
	@${TERRAFORM_CMD} plan --var-file=variables.${TARGET_ENV}.tfvars

_refresh:
	@${TERRAFORM_CMD} refresh --var-file=variables.${TARGET_ENV}.tfvars

_apply:
ifdef AUTO_APPROVE
		@${TERRAFORM_CMD} apply --auto-approve --var-file=variables.${TARGET_ENV}.tfvars
else
		@${TERRAFORM_CMD} apply --var-file=variables.${TARGET_ENV}.tfvars
endif

_destroy:
ifdef AUTO_APPROVE
	@${TERRAFORM_CMD} destroy --auto-approve --var-file=variables.${TARGET_ENV}.tfvars
else
	@${TERRAFORM_CMD} destroy --var-file=variables.${TARGET_ENV}.tfvars
endif

_check-format:
	@${TERRAFORM_CMD} fmt -check ${DIR}

_format:
	@${TERRAFORM_CMD} fmt -write=true ${DIR}

_remove-state:
	@${TERRAFORM_CMD} state rm ${args}

_import-state:
	@${TERRAFORM_CMD} import --var-file=${TFVARS_file} ${args}

state-output:
	@${TERRAFORM_CMD} output ${OUTPUT_KEY}
