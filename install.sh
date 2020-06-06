#!/bin/sh
set -e

get_latest_release() {
  curl --silent "https://api.github.com/repos/alecjacobs5401/kubectl-podevents/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}

version=$(get_latest_release)
os=$(uname -s | tr '[:upper:]' '[:lower:]')

curl -sSL https://github.com/alecjacobs5401/kubectl-podevents/releases/download/$version/kubectl-podevents_${version}_${os}_amd64.tar.gz |
  tar xz -C /usr/local/bin/ kubectl-podevents
