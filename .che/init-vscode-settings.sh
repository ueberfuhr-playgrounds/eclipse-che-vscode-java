#!/usr/bin/env bash

# Setzt VS-Code-Maschinen-Settings; bestehende Werte bleiben erhalten
SRC="$PROJECT_SOURCE/.che/machine-settings.json"
MS=/checode/remote/data/Machine/settings.json

[ -f "$SRC" ] || exit 0
mkdir -p "$(dirname "$MS")"
if [ -s "$MS" ] && command -v jq >/dev/null; then
  jq -s '.[0] * .[1]' "$MS" "$SRC" > "$MS.tmp" && mv "$MS.tmp" "$MS"
else
  cp "$SRC" "$MS"
fi
