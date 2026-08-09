#!/bin/sh

set -eu

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
NETWORK=kupalo

podman kube down "$PROJECT_ROOT/k8s/backend.yaml"
podman kube down "$PROJECT_ROOT/k8s/postgres.yaml"
podman kube down "$PROJECT_ROOT/k8s/secrets.yaml"
podman network exists "$NETWORK" && podman network rm "$NETWORK" || true
