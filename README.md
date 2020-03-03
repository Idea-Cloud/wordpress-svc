# Wordpress Service

## Prerequisites
* Only tested on Fedora 30 (5.4.19-100.fc30.x86_64)
* Docker version > 19.03.6
* GNU Make > 4.2.1
* A valid public domain in route53 (with hostedzone)

## Quick install and setup for impatient people
```bash
export PROD_AWS_ACCESS_KEY_ID=<aws_access_key_id> \
PROD_AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> \
PROD_AWS_DEFAULT_REGION=<aws_default_region> \
WP_DOMAIN_NAME=<exemple.com> \
TARGET_ENV=prod; \
make install && AUTO_APPROVE=1 make apply
```

## Install (build image with deps)
```bash
make install
```

## Apply
```bash
PROD_AWS_ACCESS_KEY_ID=<aws_access_key_id> PROD_AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> PROD_AWS_DEFAULT_REGION=<aws_default_region> TARGET_ENV=prod make apply
```

## Debug mode
```bash
PROD_AWS_ACCESS_KEY_ID=<aws_access_key_id> PROD_AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> PROD_AWS_DEFAULT_REGION=<aws_default_region> TARGET_ENV=prod WP_DEBUG=1 make apply
```

## New version
```bash
PROD_AWS_ACCESS_KEY_ID=<aws_access_key_id> PROD_AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> PROD_AWS_DEFAULT_REGION=<aws_default_region> TARGET_ENV=prod WP_VERSION=5.3.2-php7.4-apache make apply
```

## Plan
```bash
PROD_AWS_ACCESS_KEY_ID=<aws_access_key_id> PROD_AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> PROD_AWS_DEFAULT_REGION=<aws_default_region> TARGET_ENV=prod make plan
```

## Destroy (remove s3 bucket too)
```bash
PROD_AWS_ACCESS_KEY_ID=<aws_access_key_id> PROD_AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> PROD_AWS_DEFAULT_REGION=<aws_default_region> TARGET_ENV=prod make destroy
```

## Uninstall (remove image)
```bash
PROD_AWS_ACCESS_KEY_ID=<aws_access_key_id> PROD_AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> PROD_AWS_DEFAULT_REGION=<aws_default_region> TARGET_ENV=prod make uninstall
```

## Licence

```text
Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
