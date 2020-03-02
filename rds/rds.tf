################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group-${var.environment}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets
}

resource "aws_security_group" "db_security_group" {
  name        = "sgr-db-${var.environment}"
  description = "Communication with RDS"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_db_instance" "db_instance" {
  #  availability_zone    =
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_security_group.id]

  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp2"

  engine         = "mysql"
  engine_version = "5.7"

  identifier           = "rds-${var.environment}"
  instance_class       = var.db_instance_class
  name                 = "mysql${var.environment}"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"

  # For testing purpose
  apply_immediately   = true
  skip_final_snapshot = true
}

resource "null_resource" "create-kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${data.terraform_remote_state.eks.outputs.cluster_name}"
  }
}

resource "null_resource" "apply-wp-controller" {
  provisioner "local-exec" {
    command = "cat <<EOF | kubectl apply -f -\n${templatefile("${path.module}/mysql-service.yaml.tmpl", { db_endpoint = aws_db_instance.db_instance.address })} \nEOF"
  }

  #  provisioner "local-exec" {
  #    when    = destroy
  #    command = "cat <<EOF | kubectl delete -f -\n${templatefile("${path.module}/mysql-service.yaml.tmpl", { db_endpoint = aws_db_instance.db_instance.address })} \nEOF"
  #  }

  depends_on = [
    aws_db_instance.db_instance,
    null_resource.create-kubeconfig
  ]
}
