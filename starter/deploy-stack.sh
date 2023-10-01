#!/bin/bash
# Automation script for CloudFormation templates. 
#
# Parameters
#   $1: The name of the cloudformation stack
#   $2: The name of the template file
#   $3: The name of the parameters file
#   $4: AWS region
#
# Usage examples:
#   ./deploy-stack.sh udacity-iac-script iac-example.yml iac-example-params.json us-east-1
#

echo "Checking if stack exists ..."

if ! aws cloudformation describe-stacks --region $4 --stack-name $1 ; then

  echo -e "\nCreating a new $1 stack..."
  aws cloudformation create-stack \
  --stack-name $1 \
  --template-body file://$2 \
  --parameters file://$3 \
  --region $4 \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND
  
  echo "Waiting for stack to be created..."
  aws cloudformation wait stack-create-complete --stack-name $1 --region $4

else

  echo -e "\nStack $1 already exists, trying to update..."

  set +e

  update_output=$(aws cloudformation update-stack \
    --stack-name $1 \
    --template-body file://$2 \
    --parameters file://$3 \
    --region $4 \
     --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND 2>&1)

  status=$?
  set -e

  echo "$update_output"

  if [ $status -ne 0 ] ; then

    # Don't fail for no-op update
    if [[ $update_output == *"ValidationError"* && $update_output == *"No updates"* ]] ; then
      echo -e "\nFinished create/update - no updates to be performed"
      exit 0
    else
      exit $status
    fi
  fi

  echo "Waiting for stack to be updated..."
  aws cloudformation wait stack-update-complete --stack-name $1 --region $4

fi

  echo "Stack $1 has been successfully created/updated!"