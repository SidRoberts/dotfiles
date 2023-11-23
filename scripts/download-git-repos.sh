#!/usr/bin/env bash

repos=$(gh repo list | head -n -2 | cut -f1)

cd ~/Code/

for repo in $repos; do
    gh repo clone "${repo}"
done
