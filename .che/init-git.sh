#!/usr/bin/env bash
cd "$PROJECT_SOURCE" || exit 0
USERNAME="${DEVWORKSPACE_NAMESPACE%-che}"
BRANCH="solution/$USERNAME"

# Git-Identität setzen, falls noch nicht vorhanden
git config --global user.name  >/dev/null || git config --global user.name  "$USERNAME"
git config --global user.email >/dev/null || git config --global user.email "$USERNAME@schulung.local"

# Branch nur beim ersten Start anlegen, danach nichts anfassen
if ! git rev-parse --verify --quiet "$BRANCH" >/dev/null; then
  git switch -c "$BRANCH"
fi
