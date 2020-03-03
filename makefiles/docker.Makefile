################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

run-in-docker:
	@docker run --volume ${ROOT_DIR}:/data --workdir /data --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} -it ${DOCKER_IMAGE_NAME} /bin/sh -c "${COMMAND}"

make-in-docker:
	@make run-in-docker COMMAND="${LOCAL_ENV} make ${MAKE_RULE} args='${args}'"

shell-in-docker:
	docker run --volume ${ROOT_DIR}:/data --workdir /data --user ${LOCAL_USER_UID}:${LOCAL_USER_GID} -it ${DOCKER_IMAGE_NAME} /bin/bash
