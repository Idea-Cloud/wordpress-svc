################################################################################
# This file is part of the "wordpress-svc" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

FROM debian:10-slim

ENV TERRAFORM_VERSION=0.12.21
ENV KUBECTL_VERSION=1.14.6

RUN apt-get update && apt-get install -y \
  make \
  unzip \
  curl \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p  /usr/local/terraform \
  && curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > /tmp/terraform.zip \
  && unzip -od /usr/local/terraform /tmp/terraform.zip \
  && rm /tmp/terraform.zip \
  && chmod +x /usr/local/terraform/terraform
ENV PATH="${PATH}:/usr/local/terraform"

RUN mkdir -p  /usr/local/awscli \
  && curl -L "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" \
  && unzip -od /usr/local/awscli /tmp/awscliv2.zip \
  && rm /tmp/awscliv2.zip \
  && ./usr/local/awscli/aws/install

RUN mkdir -p  /usr/local/kubectl \
  && curl -L https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/2019-08-22/bin/linux/amd64/kubectl > /usr/local/kubectl/kubectl \
  && chmod +x /usr/local/kubectl/kubectl
ENV PATH="${PATH}:/usr/local/kubectl"

CMD ["terraform", "version"]
