################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

TFSTATE_KEY=${WP_TFSTATE_KEY}

include ../makefiles/vars.Makefile

include ../makefiles/terraform.Makefile
include ../makefiles/tools.Makefile

plan:
	@make _plan

apply:
	@make _apply

refresh:
	@make _refresh

destroy:
	@make _destroy

remove-state:
	@make _remove-state args=${args}

import-state:
	@make _import-state args="${args}"

check-format:
	@make _check-format DIR=.

format:
	@make _format DIR=.
