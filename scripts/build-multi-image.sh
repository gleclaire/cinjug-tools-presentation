#!/usr/bin/env bash

MYDIR="$(dirname "$(which "$0")")"
echo $MYDIR

source $MYDIR/aws-func.sh

APP_IMAGE=sample-project

if [ -n "$1" ]
then
  setEnv
  PLATFORM="--platform linux/amd64"
  IMAGE_TAG=latest
fi

export ECR_ACCOUNT=$AWS_ACCOUNT_ID.dkr.ecr.us-east-2.amazonaws.com

echo 'AWS_DEFAULT_REGION : '$AWS_DEFAULT_REGION
echo 'AWS_DEFAULT_PROFILE: '$AWS_DEFAULT_PROFILE
echo 'AWS_ACCOUNT_ID     : '$AWS_ACCOUNT_ID
echo 'ECR_ACCOUNT        : '$ECR_ACCOUNT
echo 'IMAGE_TAG          : '$IMAGE_TAG


  if [ -z "$IMAGE_REPO_NAME" ]
  then
    IMAGE_REPO_NAME=$ECR_ACCOUNT/sample-project
  fi



echo ''
echo ''
echo ''
echo 'IMAGE_REPO_NAME : '$IMAGE_REPO_NAME
echo 'TC_CONTEXT      : '$TC_CONTEXT
echo 'PLATFORM        : '$PLATFORM

setVersion

echo Logging into ECR
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $ECR_ACCOUNT

echo "buildx setup......\n"
docker buildx create  --node sample_project --name sample_project

docker buildx use --builder sample_project

echo "Starting build ..."
docker buildx build \
  --platform linux/amd64,linux/arm64  \
  --tag $ECR_ACCOUNT/$IMAGE_REPO_NAME:$VERSION_INFO \
  --tag $ECR_ACCOUNT/$IMAGE_REPO_NAME:latest \
  --push=true \
  -f Dockerfile .

echo "Finished build ..."



echo "Viewing Image: $ECR_ACCOUNT/$IMAGE_REPO_NAME:$VERSION_INFO"
docker buildx imagetools inspect $ECR_ACCOUNT/$IMAGE_REPO_NAME:$VERSION_INFO --raw

docker buildx use --builder default
