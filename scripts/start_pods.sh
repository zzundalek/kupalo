#!/bin/sh

set -eu

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
NETWORK=kupalo

podman network exists "$NETWORK" || podman network create "$NETWORK"
podman kube play --network "$NETWORK" "$PROJECT_ROOT/k8s/secrets.yaml"
podman kube play --network "$NETWORK" "$PROJECT_ROOT/k8s/postgres.yaml"
podman kube play --network "$NETWORK" "$PROJECT_ROOT/k8s/backend.yaml"
