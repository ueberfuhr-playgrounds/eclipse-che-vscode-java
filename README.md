# Eclipse Che – VS Code – Java (schlank)

Schlanke Java-Lernumgebung für Eclipse Che: VS Code (Che-Code) im Browser mit nur einer Extension (`redhat.java`).

## Starten

```
<cheURL>/#https://github.com/ueberfuhr-playgrounds/eclipse-che-vscode-java
```

Nach dem Start warten, bis in der Statusleiste **Java: Ready** steht, dann `src/HelloWorld.java` öffnen und über `main` auf **Run** klicken.

## Inhalt

| Datei | Zweck |
|---|---|
| `devfile.yaml` | Container-Image (inkl. JDK) und Ressourcen (1–2 GiB RAM) |
| `.che/che-editor.yaml` | Legt VS Code als Editor fest |
| `.vscode/extensions.json` | Installiert `redhat.java` |
| `.vscode/settings.json` | Begrenzt den Java-Language-Server, `src/` als Quellordner (ohne Maven) |
| `src/` | Java-Quellcode |
