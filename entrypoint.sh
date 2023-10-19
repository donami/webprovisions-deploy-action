#!/bin/bash
set -e

orgname=$(jq -r '.organizationName' webprovisions.json)
wp_version=$(jq -r '.version' webprovisions.json)
distname=$(jq -r '.distributionName' webprovisions.json)

/bin/minio-binaries/mc alias set wpminio $INPUT_MINIO_HOST $INPUT_MINIO_ACCESS_KEY $INPUT_MINIO_SECRET_KEY

/bin/minio-binaries/mc admin info wpminio

/bin/minio-binaries/mc cp --recursive ./dist/ wpminio/$orgname/$distname/$wp_version/

curl -X PUT $INPUT_WP_API/distributions/$distname/status \
    -H "Content-Type: application/json" \
    -d '{"version": "'$wp_version'", "status": "complete"}'