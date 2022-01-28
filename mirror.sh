#!/usr/bin/env bash

target_repo=$1

if [ -z "$target_repo" ]; then
    echo "Usage: mirror.sh <target_repo>"
    exit 1
fi

git push --mirror $target_repo

# ./mirror.sh https://github.com/CoterieAI/terraform-azure-k8s.git