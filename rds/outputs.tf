################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

output "name" {
  value = aws_db_instance.db_instance.name
}

output "endpoint" {
  #  value = aws_db_instance.db_instance.endpoint
  value = "mysql-service:3306"
}

output "db_username" {
  value = aws_db_instance.db_instance.username
}

output "db_password" {
  value     = aws_db_instance.db_instance.password
  sensitive = true
}
