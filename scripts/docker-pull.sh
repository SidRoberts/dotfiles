#!/usr/bin/env bash

set -e

images=(
    "sidroberts/beanstalkd:1.12"
    "sidroberts/beanstalkd:latest"
    "sidroberts/mailhog:1.0.1"
    "sidroberts/mailhog:latest"
    "sidroberts/php:latest"
    "nginx:1-alpine"
)

for image in "${images[@]}"; do
    docker pull "${image}"
done
