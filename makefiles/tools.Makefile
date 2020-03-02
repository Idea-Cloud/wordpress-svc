################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

install:
	@echo "Building Docker image \"${DOCKER_IMAGE_NAME}\""
	@docker build -t ${DOCKER_IMAGE_NAME} .
	@mkdir -p ${ROOT_DIR}/.config

uninstall:
	@docker rmi -f $$(docker images --format '{{.Repository}}:{{.Tag}}' | grep '${TARGET_DOCKER_REGISTRY}/${TARGET_IMAGE_NAME}')

env:
	@$(foreach v, $(.VARIABLES), $(info $(v) = $($(v))))
