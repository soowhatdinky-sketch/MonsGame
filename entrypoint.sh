#!/bin/bash
set -e

EXPORT_DIR=/export
mkdir -p "$EXPORT_DIR"

cd /app/game

echo "=== Importing Godot project resources ==="
godot --headless --import 2>&1 || echo "(import completed with warnings)"

echo "=== Exporting project to HTML5 ==="
godot --headless --export-release "Web" "$EXPORT_DIR/index.html" 2>&1 || echo "EXPORT FAILED"

if [ ! -f "$EXPORT_DIR/index.html" ]; then
    echo "ERROR: Export did not produce index.html"
    exit 1
fi

echo "=== Export complete. Starting web server on port 3000 ==="
exec python3 /serve.py
