#!/bin/bash

set -x

if [[ -z "${VERSION}" ]]; then
    VERSION=0.9.0
fi
if [[ -z "${TARGET_REPO}" ]]; then
    TARGET_REPO=lisy09/haproxy-exporter
fi
if [[ -z "${TARGET_PLATFORM}" ]]; then
    TARGET_PLATFORM=linux/amd64,linux/arm64,linux/arm/v7
fi

docker buildx build --file Dockerfile \
    --build-arg VERSION=${VERSION} \
    --tag ${TARGET_REPO}:v${VERSION} \
    --platform ${TARGET_PLATFORM} \
    . --push
