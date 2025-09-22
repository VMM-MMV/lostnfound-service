#!/bin/bash
set -a
# Load .env file if it exists
if [ -f .env ]; then
  source <(grep -v '^[[:space:]]*#' .env | xargs -d '\n')
fi
set +a