#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

KEY_PATH=~/.ssh/aws_ec2_$(terraform output -raw server_id)

if [ -e $KEY_PATH ]; then
  rm -f $KEY_PATH
fi

terraform output private_key | tee $KEY_PATH > /dev/null

chmod 400 $KEY_PATH

ssh -o StrictHostKeyChecking=no -i $KEY_PATH\
    $(terraform output -raw username)@$(terraform output -raw public_dns)
