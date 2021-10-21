#!/bin/bash
# Upload all files from OUTDIR into a single github release.
# Required variables:
#  GH_USER - uploading user
#  GH_TOKEN - token of uploading user
#  GH_REPO_USER - owner of repository
#  GH_REPO - repository name
#  Branch - kernel branch
set +x
releaseId=$(curl --user "$GH_USER:$GH_TOKEN" -X POST https://api.github.com/repos/${GH_REPO_USER}/${GH_REPO}/releases -d "{\"tag_name\": \"$(date +%4Y%m%d%H%M)\",\"target_commitish\": \"$Branch\",\"name\": \"$(date +%4Y%m%d%H%M) Kernel\",\"body\": \"Automatically built.\",\"draft\": false,\"prerelease\": false}" | python -c 'import json,sys;print(json.load(sys.stdin)["id"])')
for file_name in $(find "$PKG_OUTDIR" -type f); do
  curl --user "$GH_USER:$GH_TOKEN" -X POST https://uploads.github.com/repos/${GH_REPO_USER}/${GH_REPO}/releases/${releaseId}/assets?name=$(basename "${file_name}") --header 'Content-Type: application/octet-stream' --upload-file ${file_name}
done
set -x
