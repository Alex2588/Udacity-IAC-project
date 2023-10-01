#!/bin/bash
#
# Usage examples:
#   ./delete-stack.sh udacity-iac-script us-east-1
#

aws cloudformation delete-stack --stack-name $1 --region $2