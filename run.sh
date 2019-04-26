#!/usr/bin/env sh
set -euo pipefail

# Environment
SRC_REPO="${SRC_REPO?Missing source repository}"
DST_REPO="${DST_REPO?Missing destination repository}"

SLEEP_TIME__S="${SLEEP_TIME__S:-60}"
HTTP_SSL_VERIFY="${HTTP_SSL_VERIFY:-true}"

git config --global http.sslVerify "${HTTP_SSL_VERIFY}"

LOCAL_REPO="$(mktemp -d)"
git clone --mirror "${SRC_REPO}" "${LOCAL_REPO}"

cd "${LOCAL_REPO}"
while true; do
  git remote update
  git push --mirror "${DST_REPO}"
  sleep "${SLEEP_TIME__S}"
done
