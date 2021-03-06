#!/bin/bash
set -e

# Install and publish
if git describe --exact-match >&/dev/null; then
  TAG=$(git describe --exact-match)
  echo "Deploying $TAG tag"

  # Install
  yarn install
  # Build
  lerna bootstrap
  lerna run build
  # Run JS dev
  lerna run --scope @bitnami/hex-js build:dev

  # Prepare the folder
  BUCKET=$BUCKET yarn run cdn
else
  echo "No new tags. Skipping the publishing"
fi
