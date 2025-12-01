#!/bin/bash

# Script to check if an ECR repository exists and create it if it doesn't
# Usage: ./check-ecr-repo.sh <repository-name>
# Example: ./check-ecr-repo.sh foo/bar

set -e

REPO_NAME="${1}"

if [ -z "$REPO_NAME" ]; then
    echo "Error: Repository name is required"
    echo "Usage: $0 <repository-name>"
    echo "Example: $0 foo/bar"
    exit 1
fi

# Check if repository exists - exit early if it does
if aws ecr describe-repositories --repository-names "${REPO_NAME}" --no-cli-pager 2>/dev/null >/dev/null; then
    exit 0
fi

echo "Repository '${REPO_NAME}' does not exist. Creating..."

# Create repository with immutable tags, but allow 'latest' to be mutable
aws ecr create-repository \
    --repository-name "${REPO_NAME}" \
    --image-tag-mutability IMMUTABLE_WITH_EXCLUSION \
    --image-tag-mutability-exclusion-filters filterType=WILDCARD,filter=latest \
    --no-cli-pager

echo "Repository '${REPO_NAME}' created"
