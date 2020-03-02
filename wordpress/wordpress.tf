################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

# TODO create db from tf
#resource "mysql_database" "db_wordpress" {
#  name = "db-${var.environment}-wordpress"
#}

resource "null_resource" "create-kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${data.terraform_remote_state.eks.outputs.cluster_name}"
  }
}

locals {
  wp-controller-content = templatefile("${path.module}/wp-controller.json.tmpl", {
    wp_version      = var.wp_version
    wp_db_host      = data.terraform_remote_state.rds.outputs.endpoint
    wp_db_user      = data.terraform_remote_state.rds.outputs.db_username
    wp_db_password  = data.terraform_remote_state.rds.outputs.db_password
    wp_db_name      = "db-${var.environment}-wordpress"
    wp_table_prefix = "${var.environment}_"
    wp_debug        = "${var.wp_debug}"
  })
  wp-service-content = templatefile("${path.module}/wp-service.json.tmpl", {
    certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
  })
}

resource "null_resource" "apply-wp-controller" {
  triggers = {
    trig = local.wp-controller-content
  }

  provisioner "local-exec" {
    command = "cat <<EOF | kubectl apply -f -\n${local.wp-controller-content} \nEOF"
  }

  #  provisioner "local-exec" {
  #    when    = destroy
  #    command = "cat <<EOF | kubectl delete -f -\n${local.wp-controller-content} \nEOF"
  #  }

  depends_on = [
    null_resource.create-kubeconfig
  ]
}

resource "null_resource" "apply-wp-service" {
  triggers = {
    trig = local.wp-service-content
  }

  provisioner "local-exec" {
    command = "cat <<EOF | kubectl apply -f -\n${local.wp-service-content} \nEOF"
  }

  #  provisioner "local-exec" {
  #    when    = destroy
  #    command = "cat <<EOF | kubectl delete -f -\n${local.wp-service-content} \nEOF"
  #  }

  depends_on = [
    null_resource.apply-wp-controller,
    aws_acm_certificate_validation.cert
  ]
}
