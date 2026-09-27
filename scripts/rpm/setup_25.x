#!/usr/bin/env bash
set -euo pipefail

if ! command -v stress-ng >/dev/null 2>&1; then
  if command -v apt-get >/dev/null 2>&1; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y stress-ng
  elif command -v microdnf >/dev/null 2>&1; then
    microdnf install -y stress-ng
  elif command -v dnf >/dev/null 2>&1; then
    dnf install -y stress-ng
  elif command -v yum >/dev/null 2>&1; then
    yum install -y stress-ng
  else
    echo "No supported package manager found to install stress-ng" >&2
    exit 1
  fi
fi

# 32 minutes = 1920 seconds
stress-ng --cpu 0 --timeout 1920s --metrics-brief