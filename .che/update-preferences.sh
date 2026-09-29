#!/usr/bin/env bash
set -u
cd "$PROJECT_SOURCE" || exit 1
BRANCH="solution/${DEVWORKSPACE_NAMESPACE%-che}"

echo "» Hole Änderungen von main …"
git fetch origin main || { echo "✗ Fetch fehlgeschlagen (Netzwerk?)"; exit 1; }
git fetch origin main:main 2>/dev/null || true   # lokales main mitziehen

STASHED=false
if [ -n "$(git status --porcelain)" ]; then
  echo "» Sichere lokale Änderungen (stash) …"
  git stash push --include-untracked -m "auto: vor Kursupdate $(date +%F_%T)"
  STASHED=true
fi

git switch "$BRANCH" >/dev/null 2>&1 || git switch -c "$BRANCH"

if ! git merge --no-edit origin/main; then
  echo "✗ Konflikt beim Mergen. Bitte die Trainerin/den Trainer rufen."
  echo "  (Abbrechen mit: git merge --abort)"
  exit 1
fi

if $STASHED; then
  echo "» Stelle lokale Änderungen wieder her …"
  if ! git stash pop; then
    echo "✗ Konflikt beim Wiederherstellen. Die Änderungen liegen sicher im Stash (git stash list)."
    exit 1
  fi
fi
echo "✓ Kursupdate eingespielt."
