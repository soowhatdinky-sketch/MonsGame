# MonsGame — Base44 Dev Environment

## What this is
A Godot 4.3 game project ("MonsGame") — a simple 3D space flight game. The playable game lives in `scenes/` and `scripts/`. The repo root also contains many Godot 3.x assets (`.glb`, `.tscn`, `.gd`) from an older project that are NOT part of the runnable game and produce import warnings (harmless).

## How it runs
The app is exported to HTML5 (WebGL) and served on port 3000. There is no live-reload dev server — Godot requires a full export step. The Docker container (`Dockerfile.base44`) downloads Godot 4.3 headless + web export templates at build time, then on each startup imports the project and exports it to `/export`, serving the result with a Python HTTP server.

## Key files
- `project.godot` — Godot 4 project config; main scene is `res://scenes/Main.tscn`
- `export_presets.cfg` — HTML5 web export preset ("Web")
- `Dockerfile.base44` — builds the Godot export + serve environment
- `docker-compose.base44.yml` — compose service binding port 3000 and mounting the source
- `entrypoint.sh` — runs `godot --headless --import`, then `--export-release "Web"`, then serves
- `serve.py` — Python HTTP server with COOP/COEP headers + correct wasm MIME type

## Re-exporting after edits
Source is bind-mounted at `/app`. To see code changes, restart the container:
```
docker compose -f docker-compose.base44.yml restart web
```
This re-imports and re-exports the project (~30s), then serves the updated build.

## Godot 4 compatibility notes
- `Vector3.linear_interpolate()` → `Vector3.lerp()` (Godot 4 rename)
- `MultiMesh.COLOR_8BIT` / `CUSTOM_DATA_NONE` constants are not accessible in Godot 4.3 GDScript — removed; defaults work fine
- Renderer set to `gl_compatibility` for WebGL support

## No external secrets required
This is a self-contained game with no external service dependencies.
