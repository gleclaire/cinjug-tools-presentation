#!/usr/bin/env bash

MYDIR="$(dirname "$(which "$0")")"

echo $MYDIR


JHIPSTER_PROJECT="$(readlink -f $PWD/)"

echo Pulling Images.....
env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
env AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
env AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
env AWS_REGION=$AWS_DEFAULT_REGION \
env AWS_EMAIL_HOST=$AWS_EMAIL_HOST \
env AWS_EMAIL_PORT=$AWS_EMAIL_PORT \
env AWS_EMAIL_USER=$AWS_ACCESS_KEY_ID \
env AWS_EMAIL_PASSWORD=$AWS_SECRET_ACCESS_KEY \
env APPLE_PRIMARY_SECRET=$APPLE_PRIMARY_SECRET \
env APPLE_SECONDARY_SECRET=$APPLE_SECONDARY_SECRET \
env MAGENTO_ADMIN_TOKEN="$MAGENTO_ADMIN_TOKEN" \
env MAGENTO_TEST_TOKEN_IGNORE=$MAGENTO_TEST_TOKEN_IGNORE \
env LISTRAK_CLIENT_ID=$LISTRAK_CLIENT_ID \
env LISTRAK_CLIENT_SECRET=$LISTRAK_CLIENT_SECRET \
env FAA_WINGS_KEY=$FAA_WINGS_KEY \
env ARCH=$ARCH \
env JHIPSTER_PROJECT=$JHIPSTER_PROJECT \
env PLAY_PROJECT=$PLAY_PROJECT \
docker compose -f ./docker/elasticsearch.yml -f ./docker/sample_project.db.yml -f ./docker/minio.yml -f ./docker/imgproxy.yml -f ./docker/jhipster.yml pull

echo Running Images.....
env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
env AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
env AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
env AWS_REGION=$AWS_DEFAULT_REGION \
env AWS_EMAIL_HOST=$AWS_EMAIL_HOST \
env AWS_EMAIL_PORT=$AWS_EMAIL_PORT \
env AWS_EMAIL_USER=$AWS_ACCESS_KEY_ID \
env AWS_EMAIL_PASSWORD=$AWS_SECRET_ACCESS_KEY \
env APPLE_PRIMARY_SECRET=$APPLE_PRIMARY_SECRET \
env APPLE_SECONDARY_SECRET=$APPLE_SECONDARY_SECRET \
env MAGENTO_ADMIN_TOKEN="$MAGENTO_ADMIN_TOKEN" \
env MAGENTO_TEST_TOKEN_IGNORE=$MAGENTO_TEST_TOKEN_IGNORE \
env LISTRAK_CLIENT_ID=$LISTRAK_CLIENT_ID \
env LISTRAK_CLIENT_SECRET=$LISTRAK_CLIENT_SECRET \
env FAA_WINGS_KEY=$FAA_WINGS_KEY \
env ARCH=$ARCH \
env JHIPSTER_PROJECT=$JHIPSTER_PROJECT \
env PLAY_PROJECT=$PLAY_PROJECT \
docker compose -f ./docker/elasticsearch.yml -f ./docker/sample_project.db.yml -f ./docker/minio.yml -f ./docker/imgproxy.yml -f ./docker/jhipster.yml $*
