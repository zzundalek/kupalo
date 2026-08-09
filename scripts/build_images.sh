#!/bin/sh

set -eu

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

TAG="kupalo-"

podman build \
	-t "${TAG}postgres" \
	"$PROJECT_ROOT/postgres/"

# Backend build image - can be used for caching
podman build \
	--target build \
	-t "${TAG}backend-build" \
	"$PROJECT_ROOT/backend/"

podman build \
	--target backend \
	-t "${TAG}backend" \
	"$PROJECT_ROOT/backend/"

podman build \
	--target migrate \
	-t "${TAG}migrate" \
	"$PROJECT_ROOT/backend/"
