#!/usr/bin/env bash
EXTENSIONS=(
  redhat.java
  vscjava.vscode-java-dependency
  vscjava.vscode-java-debug
  EditorConfig.EditorConfig
)
INSTALLED=$(code-oss --list-extensions 2>/dev/null)
for EXT in "${EXTENSIONS[@]}"; do
  if ! grep -qix "$EXT" <<< "$INSTALLED"; then
    echo "» Installiere $EXT …"
    code-oss --install-extension "$EXT" || echo "✗ $EXT fehlgeschlagen"
  fi
done
echo "✓ Extensions bereit."
