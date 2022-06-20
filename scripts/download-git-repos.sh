#!/usr/bin/env bash

set -e

repos=(
    "ssh://git@github.com/SidRoberts/centum.git"
    "ssh://git@github.com/SidRoberts/centum-project.git"
)

cd ~/Code/

for repo in "${repos[@]}"; do
    git clone "${repo}"
done
