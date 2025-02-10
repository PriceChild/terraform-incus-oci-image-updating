#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Extract "foo" and "baz" arguments from the input into
# FOO and BAZ shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "DOCKER_SOURCE_IMAGE=\(.docker_image) TAG=\(.tag)"')"

DOCKER_NAMESPACE=${DOCKER_SOURCE_IMAGE%/*}
DOCKER_IMAGE=${DOCKER_SOURCE_IMAGE#*/}

if [ "${TAG}" == "null" ]
then
    TAG=latest
fi

FULL_DIGEST=$(curl https://hub.docker.com/v2/namespaces/$DOCKER_NAMESPACE/repositories/$DOCKER_IMAGE/tags/$TAG 2>/dev/null | jq '.digest' -r | cut -d\: -f 2)

jq -n --arg fingerprint "$FULL_DIGEST" --arg short_digest "${FULL_DIGEST:0:12}" '{"fingerprint":$fingerprint, "short_digest":$short_digest}'
