#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Extract "foo" and "baz" arguments from the input into
# FOO and BAZ shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "DOCKER_SOURCE_IMAGE=\(.docker_image)"')"

if [[ $DOCKER_SOURCE_IMAGE == *":"* ]]
then
    DOCKER_TAG=${DOCKER_SOURCE_IMAGE#*:}
    DOCKER_IMAGE=${DOCKER_SOURCE_IMAGE%:*}
else
    DOCKER_TAG="latest"
    DOCKER_IMAGE=${DOCKER_SOURCE_IMAGE}
fi

if [[ $DOCKER_IMAGE == *"/"* ]]
then
    DOCKER_NAMESPACE=${DOCKER_IMAGE%/*}
    DOCKER_IMAGE=${DOCKER_IMAGE#*/}
else
    DOCKER_NAMESPACE="_"
fi

FULL_DIGEST=$(curl https://hub.docker.com/v2/namespaces/$DOCKER_NAMESPACE/repositories/$DOCKER_IMAGE/tags/$DOCKER_TAG 2>/dev/null | jq '.digest' -r | cut -d\: -f 2)

jq -n \
    --arg fingerprint "$FULL_DIGEST" \
    --arg short_digest "${FULL_DIGEST:0:12}" \
    --arg docker_image "$DOCKER_NAMESPACE/$DOCKER_IMAGE@sha256:$FULL_DIGEST" \
    '{"fingerprint":$fingerprint, "short_digest":$short_digest, "docker_image":$docker_image}'
