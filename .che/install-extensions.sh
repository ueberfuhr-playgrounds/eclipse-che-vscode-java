#!/usr/bin/env bash
# Installiert die Extensions aus .vscode/extensions.json über code-oss.
# Probiert alle vorhandenen code-oss-Builds (ubi8/ubi9) und wartet, bis der VS-Code-Server bereit ist.

RECOMMENDATIONS="$PROJECT_SOURCE/.vscode/extensions.json"
MAX_TRIES=60   # 60 × 5 s = 5 Minuten
SLEEP=5

if [ ! -f "$RECOMMENDATIONS" ]; then
  echo "» Keine $RECOMMENDATIONS gefunden. Nichts zu tun."
  exit 0
fi

if ! command -v jq >/dev/null; then
  echo "✗ jq nicht verfügbar. Kann $RECOMMENDATIONS nicht lesen."
  exit 1
fi

EXTENSIONS=$(jq -r '.recommendations // [] | .[]' "$RECOMMENDATIONS")
if [ -z "$EXTENSIONS" ]; then
  echo "» Keine Recommendations eingetragen. Nichts zu tun."
  exit 0
fi

for i in $(seq 1 "$MAX_TRIES"); do
  for CODE in /checode/checode-linux-libc/*/bin/remote-cli/code-oss; do
    [ -x "$CODE" ] || continue
    if "$CODE" --list-extensions >/dev/null 2>&1; then
      echo "» Nutze $CODE"
      INSTALLED=$("$CODE" --list-extensions)
      for EXT in $EXTENSIONS; do
        if grep -qix "$EXT" <<< "$INSTALLED"; then
          echo "  = $EXT bereits installiert"
        else
          echo "  + Installiere $EXT"
          "$CODE" --install-extension "$EXT" || echo "  ✗ $EXT fehlgeschlagen"
        fi
      done
      echo "✓ Fertig."
      exit 0
    fi
  done
  sleep "$SLEEP"
done

echo "✗ Kein funktionierendes code-oss gefunden (Timeout nach $((MAX_TRIES * SLEEP)) s)"
exit 1
