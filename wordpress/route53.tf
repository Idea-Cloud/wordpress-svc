################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

data "aws_route53_zone" "zone" {
  name         = "${var.wp_domain_name}."
  private_zone = false
}

#resource "aws_route53_record" "www" {
#  zone_id = "${aws_route53_zone.zone.zone_id}"
#  name    = var.wp_domain_name
#  type    = "A"
#  ttl     = "300"
#  records = []
#}
