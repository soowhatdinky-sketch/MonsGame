<div align="center">

![Nemotron Nano Identity](./assets/nano-identity.svg)

# Nemotron-3-Nano Sandbox

Reproducible local benchmark workspace for `nemotron-3-nano:4b` on Windows with Ollama and `uv`.

</div>

![Model](https://img.shields.io/badge/Model-nemotron--3--nano%3A4b-0ea5e9?style=for-the-badge)
![Context](https://img.shields.io/badge/Context-2048-0ea5e9?style=for-the-badge)
![Repeat](https://img.shields.io/badge/Repeat-5-0ea5e9?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-14b8a6?style=for-the-badge)

[English](README.md) | [Japanese](README.ja.md)

## Overview

- Last benchmark timestamp: `2026-03-25 21:09:15 +09:00`
- Model tag: `nemotron-3-nano:4b`
- Ollama: `0.18.2`
- uv: `0.10.8`
- Shell: `PowerShell`
- GPU: `NVIDIA GeForce RTX 3060 Laptop GPU`
- Context length: `2048`
- Repeat count: `5`
- Source of truth: [`benchmark_latest.json`](./benchmark_latest.json)

Additional evidence files:

- [`ollama_ps.txt`](./ollama_ps.txt): `SIZE 5.2 GB`, `14%/86% CPU/GPU`, `CONTEXT 2048`
- [`nvidia_smi.txt`](./nvidia_smi.txt): `5838 MiB / 6144 MiB` snapshot at capture time
- [`ollama_version.txt`](./ollama_version.txt), [`uv_version.txt`](./uv_version.txt), [`benchmark_timestamp.txt`](./benchmark_timestamp.txt)

## Purpose

- Confirm that `nemotron-3-nano:4b` can run locally on this workstation through Ollama.
- Preserve one benchmark run as auditable evidence rather than relying on anecdotal notes.
- Provide a repeatable Windows wrapper and a minimal Python harness for future reruns.

## Prerequisites

- Windows with PowerShell
- Ollama installed locally
- `uv` installed locally

`run_benchmark.ps1` resolves executables in this order:

1. Explicit parameters `-OllamaExe` and `-UvExe`
2. Environment variables `OLLAMA_EXE` and `UV_EXE`
3. `PATH`
4. Common Windows install paths for Ollama and `uv`

## Quick Start

Primary command:

```powershell
.\run_benchmark.ps1 -Model nemotron-3-nano:4b -NumCtx 2048 -Repeat 5
```

Override executable paths when needed:

```powershell
.\run_benchmark.ps1 `
  -OllamaExe "C:\Users\<you>\AppData\Local\Programs\Ollama\ollama.exe" `
  -UvExe "C:\Users\<you>\.local\bin\uv.exe"
```

Use environment variables instead of parameters:

```powershell
$env:OLLAMA_EXE = "C:\Users\<you>\AppData\Local\Programs\Ollama\ollama.exe"
$env:UV_EXE = "C:\Users\<you>\.local\bin\uv.exe"
.\run_benchmark.ps1
```

Run the Python benchmark directly:

```powershell
uv run .\benchmark_ollama.py --model nemotron-3-nano:4b --num-ctx 2048 --repeat 5
```

Open a direct chat session:

```powershell
ollama run nemotron-3-nano:4b
```

Default prompt:

```text
Reply with exactly three short bullet points about why compact local models are useful.
```

## Results

Aggregate metrics from [`benchmark_latest.json`](./benchmark_latest.json):

| Metric | Value |
| --- | --- |
| `eval_rate_tps_avg` | `33.13 tok/s` |
| `eval_rate_tps_median` | `33.85 tok/s` |
| `eval_rate_tps_min` | `28.86 tok/s` |
| `eval_rate_tps_max` | `36.06 tok/s` |
| `total_seconds_avg` | `4.058 s` |
| `load_seconds_avg` | `0.378 s` |

Run-level detail:

| Run | `total_seconds` | `load_seconds` | `eval_rate_tps` |
| --- | --- | --- | --- |
| 1 | `4.187 s` | `0.310 s` | `32.81 tok/s` |
| 2 | `5.311 s` | `0.381 s` | `34.05 tok/s` |
| 3 | `2.965 s` | `0.284 s` | `36.06 tok/s` |
| 4 | `2.821 s` | `0.302 s` | `28.86 tok/s` |
| 5 | `5.006 s` | `0.612 s` | `33.85 tok/s` |

Illustrative `visible_response_preview` sample:

```text
- Runs locally, no data transmission.
- Low size reduces memory usage.
- Faster inference, no network latency.
```

This text is model output and is included only as a trace sample.

## Repository Layout

- [`benchmark_ollama.py`](./benchmark_ollama.py): JSON benchmark runner for `/api/generate`
- [`run_benchmark.ps1`](./run_benchmark.ps1): Windows wrapper that waits for Ollama readiness and invokes `uv run`
- [`benchmark_latest.json`](./benchmark_latest.json): latest recorded benchmark result
- [`assets/nano-identity.svg`](./assets/nano-identity.svg): repository identity asset
- [`.github/workflows/repo-scaffold-checks.yml`](./.github/workflows/repo-scaffold-checks.yml): GPU-free structural checks for CI

## Notes

- [`benchmark_ollama.py`](./benchmark_ollama.py) strips pre-`</think>` content into `visible_response_preview` for cleaner reporting.
- The repository keeps evidence files under version control so README claims can be traced to saved artifacts.
- The wrapper is Windows-oriented, but it no longer depends on one hardcoded workstation path.

## Limitations

- Only one short prompt family is measured.
- The benchmark reflects this local machine and captured session, not a universal performance claim.
- `ollama ps` values are recorded as observed output; GPU offload internals were not deeply validated.
- Cold-start-only behavior, long-running stability, and cross-model comparisons are outside this pass.

## Next Steps

- Separate cold-start and warm-start measurements.
- Add English and Japanese prompt comparisons under the same JSON schema.
- Extend the same evidence format to additional local model tags.

- Your project.godot is currently malformed because the [application] section is duplicated and the first config/description accidentally contains a large chunk of another configuration file.
For MonsGame, I would replace it with this clean version:
; MonsGame - Godot 4.7 project configuration
; Cleaned and consolidated configuration.

config_version=5

[application]

config/name="MonsGame"
config/description="MonsGame - 3D sci-fi exploration and adventure."
run/main_scene="uid://bkbv8t2yunnew"
config/features=PackedStringArray("4.7", "Forward Plus")
run/low_processor_mode=true
run/load_shell_environment=true
boot_splash/show_image=false
boot_splash/image="uid://bbccog1sy3xhv"

[animation]

compatibility/default_parent_skeleton_in_mesh_instance_3d=true

[autoload]

GdPAIAutoload="*uid://ol4q4tu0vtwo"
BootSplashPlus="*uid://bmmmyvf7c1rya"

[editor_plugins]

enabled=PackedStringArray(
"res://addons/DeeplinkPlugin/plugin.cfg",
"res://addons/GDQuest_GDScript_formatter/plugin.cfg",
"res://addons/GdPlanningAI/plugin.cfg",
"res://addons/boot_splash_plus/plugin.cfg",
"res://addons/gdscript2all/plugin.cfg"
)

[filesystem]

import/fbx2gltf/enabled.android=true
import/fbx2gltf/enabled.web=true
import/blender/enabled.android=true
import/blender/enabled.web=true

[importer_defaults]

texture={
"detect_3d/compress_to": 0
}

animation_library={
&"nodes/root_scale": 1000.0
}

[input_devices]

joypads/ignore_joypad_on_unfocused_application=true

[memory]

limits/message_queue/max_size_mb=140

[rendering]

textures/canvas_textures/default_texture_filter=2
textures/canvas_textures/default_texture_repeat=1
textures/vram_compression/import_s3tc_bptc=true
lights_and_shadows/use_physical_light_units=true
textures/default_filters/anisotropic_filtering_level=4
viewport/transparent_background=true
textures/default_filters/use_nearest_mipmap_filter=false

[threading]

worker_pool/max_threads=4
Important fixes
Removed the accidental nested project.godot content from config/description.
Removed the duplicate [application] section.
Removed the duplicate [autoload], [editor_plugins], [importer_defaults], [input_devices], and [rendering] sections.
Kept MonsGame as the project name.
Kept your Boot Splash Plus autoload.
Kept the GdPlanningAI integration.
Kept gdscript2all.
Kept your existing main-scene UID.
Kept Godot 4.7 Forward Plus.
Kept the Android/Web Blender/FBX importer settings.
Kept your performance/threading settings.
One thing to check: if uid://bkbv8t2yunnew is no longer valid because the original scene was moved/deleted, Godot will still fail to launch. In that case, the main scene needs to be changed to the actual MonsGame startup scene path/UID.
If your goal is to make this the MonsGame startup/loading system we were building, the next step is to connect this clean project.godot to the Boot Splash Plus scene and your universe startup script.
Your project.godot is currently malformed because the [application] section is duplicated and the first config/description accidentally contains a large chunk of another configuration file.
For MonsGame, I would replace it with this clean version:
; MonsGame - Godot 4.7 project configuration
; Cleaned and consolidated configuration.

config_version=5

[application]

config/name="MonsGame"
config/description="MonsGame - 3D sci-fi exploration and adventure."
run/main_scene="uid://bkbv8t2yunnew"
config/features=PackedStringArray("4.7", "Forward Plus")
run/low_processor_mode=true
run/load_shell_environment=true
boot_splash/show_image=false
boot_splash/image="uid://bbccog1sy3xhv"

[animation]

compatibility/default_parent_skeleton_in_mesh_instance_3d=true

[autoload]

GdPAIAutoload="*uid://ol4q4tu0vtwo"
BootSplashPlus="*uid://bmmmyvf7c1rya"

[editor_plugins]

enabled=PackedStringArray(
"res://addons/DeeplinkPlugin/plugin.cfg",
"res://addons/GDQuest_GDScript_formatter/plugin.cfg",
"res://addons/GdPlanningAI/plugin.cfg",
"res://addons/boot_splash_plus/plugin.cfg",
"res://addons/gdscript2all/plugin.cfg"
)

[filesystem]

import/fbx2gltf/enabled.android=true
import/fbx2gltf/enabled.web=true
import/blender/enabled.android=true
import/blender/enabled.web=true

[importer_defaults]

texture={
"detect_3d/compress_to": 0
}

animation_library={
&"nodes/root_scale": 1000.0
}

[input_devices]

joypads/ignore_joypad_on_unfocused_application=true

[memory]

limits/message_queue/max_size_mb=140

[rendering]

textures/canvas_textures/default_texture_filter=2
textures/canvas_textures/default_texture_repeat=1
textures/vram_compression/import_s3tc_bptc=true
lights_and_shadows/use_physical_light_units=true
textures/default_filters/anisotropic_filtering_level=4
viewport/transparent_background=true
textures/default_filters/use_nearest_mipmap_filter=false

[threading]

worker_pool/max_threads=4
Important fixes
Removed the accidental nested project.godot content from config/description.
Removed the duplicate [application] section.
Removed the duplicate [autoload], [editor_plugins], [importer_defaults], [input_devices], and [rendering] sections.
Kept MonsGame as the project name.
Kept your Boot Splash Plus autoload.
Kept the GdPlanningAI integration.
Kept gdscript2all.
Kept your existing main-scene UID.
Kept Godot 4.7 Forward Plus.
Kept the Android/Web Blender/FBX importer settings.
Kept your performance/threading settings.
One thing to check: if uid://bkbv8t2yunnew is no longer valid because the original scene was moved/deleted, Godot will still fail to launch. In that case, the main scene needs to be changed to the actual MonsGame startup scene path/UID.
If your goal is to make this the MonsGame startup/loading system we were building, the next step is to connect this clean project.godot to the Boot Splash Plus scene and your universe startup script.
Yes — this is the main AIAssistantHub.gd controller for your Godot AI Assistant Hub. It manages providers, Ollama/API model lists, assistant types, chats, capability detection, and version checking.
I can clean this up so it works properly with your Skull Cap + Godot 4 + Ollama setup.
The biggest thing is that this script cannot work by itself. It depends on:
addons/ai_assistant_hub/
├── AIAssistantHub.gd
├── ai_chat.tscn
├── new_ai_assistant_button.tscn
├── new_ai_assistant_type_window.tscn
├── llm_providers/
│   └── Ollama.tres
├── assistants/
├── interfaces/
├── resources/
└── ...
I would change your script in particular
Keep @tool at the top
Prevent _models_llm null crashes.
Prevent provider initialization from recursively triggering model requests.
Safely handle Ollama being offline.
Handle Ollama's /api/tags model response.
Make qwen2.5-coder:7b selectable.
Make the model list recover properly after a failed request.
Prevent duplicate signal connections.
Safely handle deleted assistant resources.
Make saved chats load without breaking the editor.
Prevent the GitHub version check from interfering with local/offline operation.
Make the UI work even when no API key is required.
Add proper error messages for 127.0.0.1:11434.
Make it compatible with the Godot 4.x syntax you're using.
For your Skull Cap setup, I'd use:
Godot
   │
   ▼
AIAssistantHub
   │
   ▼
Ollama Provider
   │
   ▼
http://127.0.0.1:11434
   │
   ├── /api/tags
   │       ↓
   │   qwen2.5-coder:7b
   │
   └── /api/chat
           ↓
       AI Assistant
           ↓
      Skull Cap tools
           ├── Create Node
           ├── Modify Scene
           ├── Write GDScript
           ├── Create Craft
           └── Project Organizer
Important: if you're running Godot on your Chromebook and Ollama is running somewhere else, 127.0.0.1 means the machine running Godot—not necessarily the machine running Ollama. In that case the provider URL needs to point to the Ollama host's LAN address.
If you want, send/upload your current addons/ai_assistant_hub folder or ZIP, and I can repair the whole addon rather than only this one script, including the provider/interface files and the Ollama connection.
Done — I rebuilt it specifically so the VTOL fighter can be deployed into the correct Godot res:// locations, rather than just being a loose asset package.
Download
SkullCap_VTOL_Godot_Deployable.zip
Inside it you'll find:
Godot_Project/
├── project.godot
├── scenes/
│   ├── Main.tscn
│   └── VTOLFighter.tscn
├── scripts/
│   ├── Main.gd
│   └── VTOLFighter.gd
├── assets/
│   └── vtol_fighter/
│       ├── VTOL_Fighter.glb
│       ├── VTOL_Fighter_source.obj
│       └── VTOL_Fighter_source.mtl
└── docs/

Deploy/
├── install_to_godot.sh
├── install_to_godot.bat
├── install_to_godot.ps1
└── README.txt
Two ways to use it
Easiest: extract the ZIP and open Godot_Project directly in Godot 4, then press Run.
Existing Skull Cap project: use the installer. It puts the files into:
res://assets/vtol_fighter/
res://scenes/
res://scripts/
and creates a backup of files it replaces.
For Termux/Chromebook, the installer is:
bash Deploy/install_to_godot.sh /path/to/your/GodotProject
I also changed the model pipeline to GLB, so Godot gets a proper imported 3D scene rather than trying to instantiate an OBJ as though it were a scene. The main scene is res://scenes/Main.tscn. ❶
Done. I opened the supplied spherocal.zip and turned it into a self-contained Godot 4 game project.
Download
SkullCap_VTOL_Godot_GameReady.zip
It includes:
✅ Godot 4 project.godot
✅ VTOL fighter 3D model, centered and reoriented for Godot
✅ OBJ + material library
✅ VTOL flight controller
✅ Throttle, pitch, yaw and roll
✅ VTOL hover mode
✅ Boost
✅ Chase camera
✅ Cockpit camera
✅ Camera switching
✅ Collision body
✅ Runway/test environment
✅ Flight HUD
✅ Reset function
✅ Chromebook-friendly Godot Compatibility renderer
✅ README with controls
✅ Original supplied files retained for reference
Controls
W/S — throttle
↑/↓ — pitch
A/D — yaw
←/→ — roll
Shift — boost
V — VTOL mode
C — camera
R — reset
Open the extracted folder in Godot 4.x and press Run. Godot will generate its .godot import cache automatically.
Note: this build is based on the model contained in the newly supplied spherocal.zip; I didn't silently substitute the earlier smooth STL. ❶
Absolutely — this is the MonsGame main-menu artwork I’d use as the visual foundation for the Boot Splash Plus system.
I’d set it up so the game starts with:
🌌 MONS GAME logo/artwork as the background
🚀 Spacecraft and planet remain visible
✨ Animated star/glow effects
START button → launches the game
SETTINGS button → opens settings
📊 Boot/loading screen before the menu
🔵 Cyan futuristic UI glow matching the artwork
✍️ “By DinkySooWhat for woofles” retained
Responsive layout for Chromebook/PC resolutions
The uploaded image can be used directly as the MonsGame splash/menu background rather than recreating the artwork.
If MonsGame is the game/project name, I’d use it in the Boot Splash Plus configuration like this:
Writing
[plugin]
name="MonsGame Boot Splash Plus" description="Custom MonsGame startup loading screen with background images, logos, animated progress bar, and loading status." author="GamingFirstOne" version="0.4.5" script="plugin.gd"
Recommended startup branding:
MONS GAME

Loading Universe...
Preparing World...
Initializing Ships...
Loading Systems...
Ready
I can also �⁠turn your uploaded universe.gd into the MonsGame startup/loading system, so the splash screen progresses based on the actual universe initialization rather than using a fake timer.
Absolutely. The clean way to do this in Godot is to give the capital ship a single coordinate/size authority: every bay, deck, corridor, hangar, prefab and dressing object gets its position and dimensions from the same configuration.
I’d use an .ini file for the ship layout and an AI-style ShipLayoutAI.gd manager that reads it, validates XYZ/size relationships, and automatically places/scales components.
1. capital_ship.ini
[ship]
name="Skull Cap Capital Ship"
size=Vector3(1000,250,1600)
origin=Vector3(0,0,0)
prefab_limit=512

[coordinate_system]
up_axis="Y"
forward_axis="Z"
right_axis="X"
units="meters"

[decks]
count=10
deck_height=20.0
margin=5.0

[bay.main_hangar]
position=Vector3(0,-70,0)
size=Vector3(300,40,500)
type="hangar"

[bay.engineering]
position=Vector3(0,-50,550)
size=Vector3(250,60,300)
type="engineering"

[bay.cargo]
position=Vector3(0,-40,-500)
size=Vector3(300,50,300)
type="cargo"

[bay.command]
position=Vector3(0,70,0)
size=Vector3(180,60,180)
type="command"

[bay.docking]
position=Vector3(400,0,0)
size=Vector3(100,100,300)
type="docking"

[interior]
wall_thickness=2.0
corridor_width=8.0
door_width=4.0
door_height=5.0
2. ShipLayoutAI.gd
extends Node3D
class_name ShipLayoutAI

@export_file("*.ini") var layout_file: String = "res://config/capital_ship.ini"

var ship_size := Vector3.ZERO
var ship_origin := Vector3.ZERO
var prefab_limit := 512

var bays: Dictionary = {}


func _ready() -> void:
	load_ship_layout()
	validate_layout()
	build_layout()


func load_ship_layout() -> void:
	var config := ConfigFile.new()

	var error := config.load(layout_file)

	if error != OK:
		push_error("ShipLayoutAI: Could not load " + layout_file)
		return

	ship_size = _parse_vector3(
		config.get_value(
			"ship",
			"size",
			Vector3(1000, 250, 1600)
		)
	)

	ship_origin = _parse_vector3(
		config.get_value(
			"ship",
			"origin",
			Vector3.ZERO
		)
	)

	prefab_limit = int(
		config.get_value(
			"ship",
			"prefab_limit",
			512
		)
	)

	for section in config.get_sections():

		if section.begins_with("bay."):
			var bay_name := section.trim_prefix("bay.")

			var bay := {
				"position": _parse_vector3(
					config.get_value(
						section,
						"position",
						Vector3.ZERO
					)
				),
				"size": _parse_vector3(
					config.get_value(
						section,
						"size",
						Vector3.ONE
					)
				),
				"type": str(
					config.get_value(
						section,
						"type",
						"generic"
					)
				)
			}

			bays[bay_name] = bay


func validate_layout() -> void:
	for bay_name in bays:

		var bay: Dictionary = bays[bay_name]

		var position: Vector3 = bay["position"]
		var size: Vector3 = bay["size"]

		var half_ship := ship_size * 0.5
		var half_bay := size * 0.5

		var minimum := position - half_bay
		var maximum := position + half_bay

		if minimum.x < -half_ship.x:
			push_warning(
				"Bay %s exceeds ship X-" % bay_name
			)

		if maximum.x > half_ship.x:
			push_warning(
				"Bay %s exceeds ship X+" % bay_name
			)

		if minimum.y < -half_ship.y:
			push_warning(
				"Bay %s exceeds ship Y-" % bay_name
			)

		if maximum.y > half_ship.y:
			push_warning(
				"Bay %s exceeds ship Y+" % bay_name
			)

		if minimum.z < -half_ship.z:
			push_warning(
				"Bay %s exceeds ship Z-" % bay_name
			)

		if maximum.z > half_ship.z:
			push_warning(
				"Bay %s exceeds ship Z+" % bay_name
			)


func build_layout() -> void:
	for bay_name in bays:
		_create_bay(
			bay_name,
			bays[bay_name]
		)


func _create_bay(
	bay_name: String,
	bay: Dictionary
) -> void:

	var node := Node3D.new()
	node.name = "Bay_" + bay_name

	node.position = (
		ship_origin +
		bay["position"]
	)

	node.set_meta(
		"layout_size",
		bay["size"]
	)

	node.set_meta(
		"bay_type",
		bay["type"]
	)

	add_child(node)

	_create_bay_volume(
		node,
		bay["size"]
	)


func _create_bay_volume(
	parent: Node3D,
	size: Vector3
) -> void:

	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = "BayVolume"

	var mesh := BoxMesh.new()
	mesh.size = size

	mesh_instance.mesh = mesh

	parent.add_child(mesh_instance)


func get_bay_position(
	bay_name: String
) -> Vector3:

	if not bays.has(bay_name):
		return ship_origin

	return ship_origin + bays[bay_name]["position"]


func get_bay_size(
	bay_name: String
) -> Vector3:

	if not bays.has(bay_name):
		return Vector3.ZERO

	return bays[bay_name]["size"]


func fit_object_to_bay(
	object: Node3D,
	bay_name: String,
	object_size: Vector3
) -> void:

	if not bays.has(bay_name):
		push_warning(
			"Unknown bay: " + bay_name
		)
		return

	var bay_size: Vector3 = get_bay_size(bay_name)

	var scale_x := bay_size.x / max(object_size.x, 0.001)
	var scale_y := bay_size.y / max(object_size.y, 0.001)
	var scale_z := bay_size.z / max(object_size.z, 0.001)

	var uniform_scale := min(
		scale_x,
		min(scale_y, scale_z)
	)

	object.position = get_bay_position(bay_name)
	object.scale = Vector3.ONE * uniform_scale


func _parse_vector3(value) -> Vector3:
	if value is Vector3:
		return value

	if value is String:
		var text := value.strip_edges()
		text = text.replace("Vector3(", "")
		text = text.replace(")", "")

		var parts := text.split(",")

		if parts.size() >= 3:
			return Vector3(
				float(parts[0]),
				float(parts[1]),
				float(parts[2])
			)

	return Vector3.ZERO
The important part
This gives you a consistent relationship:
SHIP
1000 X
 250 Y
1600 Z
   │
   ├── Main Hangar
   │      XYZ = 0,-70,0
   │      Size = 300,40,500
   │
   ├── Engineering
   │      XYZ = 0,-50,550
   │      Size = 250,60,300
   │
   ├── Cargo
   │      XYZ = 0,-40,-500
   │      Size = 300,50,300
   │
   └── Command
          XYZ = 0,70,0
          Size = 180,60,180
So instead of manually guessing where a prefab belongs, the AI/layout manager can do:
fit_object_to_bay(
	hangar_prefab,
	"main_hangar",
	Vector3(120, 20, 200)
)
and the system calculates the appropriate position and scale from the bay's XYZ + size.
This is the architecture I'd use for your capital ship because it gives you one source of truth rather than having PrefabDeckBuilder, ShipSystems, interior dressing, and individual prefabs each inventing their own coordinates.
If you're asking how to implement _make_major_bays(mat: Material3D), here's a solid Godot 4 version for your massive ship builder:
func _make_major_bays(mat: Material3D) -> void:
	# Creates the major internal bays of the ship.
	# Call this after the main hull/deck geometry exists.

	var bays := [
		{
			"name": "Main_Hangar",
			"size": Vector3(120.0, 30.0, 180.0),
			"position": Vector3(0.0, -5.0, 0.0)
		},
		{
			"name": "Engineering_Bay",
			"size": Vector3(80.0, 25.0, 100.0),
			"position": Vector3(0.0, -2.0, 150.0)
		},
		{
			"name": "Cargo_Bay",
			"size": Vector3(100.0, 25.0, 120.0),
			"position": Vector3(0.0, -2.0, -150.0)
		},
		{
			"name": "Command_Bay",
			"size": Vector3(70.0, 20.0, 70.0),
			"position": Vector3(0.0, 25.0, 0.0)
		}
	]

	for bay in bays:
		var bay_node := Node3D.new()
		bay_node.name = bay.name
		bay_node.position = bay.position
		add_child(bay_node)

		var mesh_instance := MeshInstance3D.new()
		mesh_instance.name = "BayStructure"

		var box := BoxMesh.new()
		box.size = bay.size
		mesh_instance.mesh = box
		mesh_instance.material_override = mat

		bay_node.add_child(mesh_instance)
If _make_major_bays() is being called from your generator function rather than the generated PrefabDeckBuilder.gd, make sure the function is placed inside the same class as the caller. Otherwise Godot will produce another:
Function "_make_major_bays()" not found in base self
Also, if mat can be empty, make it safer:
if mat == null:
	return
Then:
_make_major_bays(mat)
would work correctly.
Those errors mean the generator is calling four functions that don't exist in the script. The three _write_file() lines aren't the problem.
You need to add these functions to the same EditorScript:
func _get_systems_logic_source() -> String:
	return """extends Node
# Ship systems logic
"""


func _get_deck_builder_source() -> String:
	return """extends Node3D
# Procedural deck / interior builder
"""


func _get_player_controller_source() -> String:
	return """extends CharacterBody3D
# First-person player controller
"""


func _get_unified_scene_source() -> String:
	return """extends Node3D
# Unified massive ship scene
"""
Then your deployment section can remain:
_write_file(scripts_path.path_join("ShipSystems.gd"), _get_systems_logic_source())
_write_file(scripts_path.path_join("PrefabDeckBuilder.gd"), _get_deck_builder_source())
_write_file(scripts_path.path_join("FirstPersonPlayer.gd"), _get_player_controller_source())
_write_file(scenes_path.path_join("MassiveShip.tscn"), _get_unified_scene_source())
Better fix for your project
Since you're building the massive Skull Cap ship, I would not use the "\n" + \ method for these large generated scripts. It is very easy to produce exactly the parser error you just encountered.
Use Godot's multiline strings instead:
func _get_systems_logic_source() -> String:
	return """
extends Node

class_name ShipSystems

var reactor_power: float = 1.0
var life_support: float = 1.0
var shields: float = 1.0
var engines: float = 1.0

func _ready() -> void:
	print("[ShipSystems] Systems online")

func set_power(value: float) -> void:
	reactor_power = clamp(value, 0.0, 1.0)
"""


func _get_deck_builder_source() -> String:
	return """
extends Node3D

class_name PrefabDeckBuilder

@export var prefab_limit: int = 256
@export var deck_bounds_dimensions: Vector3 = Vector3(100, 10, 100)

func _ready() -> void:
	print("[PrefabDeckBuilder] Initialising deck system")
	print("[PrefabDeckBuilder] Prefab limit: ", prefab_limit)

func build_deck() -> void:
	print("[PrefabDeckBuilder] Building deck")
"""


func _get_player_controller_source() -> String:
	return """
extends CharacterBody3D

class_name FirstPersonPlayer

@export var movement_speed: float = 6.0
@export var mouse_sensitivity: float = 0.002

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	var direction := Vector3(
		input_vector.x,
		0.0,
		input_vector.y
	)

	velocity.x = direction.x * movement_speed
	velocity.z = direction.z * movement_speed

	move_and_slide()
"""


func _get_unified_scene_source() -> String:
	return """
[gd_scene format=3]

[node name="MassiveShip" type="Node3D"]

[node name="ShipSystems" type="Node" parent="."]

[node name="PrefabDeckBuilder" type="Node3D" parent="."]

[node name="Interior" type="Node3D" parent="."]

[node name="Decks" type="Node3D" parent="Interior"]

[node name="Hangars" type="Node3D" parent="Interior"]

[node name="Engineering" type="Node3D" parent="Interior"]
"""
This approach eliminates the + \ concatenation problem entirely.
One other thing: your _get_unified_scene_source() is generating a .tscn, so its content must be scene-file syntax, not GDScript. The version above handles that correctly.
Those three lines are correct GDScript as long as they are inside your generator function and _write_file() / the three _get_*_source() functions exist:
_write_file(scripts_path.path_join("ShipSystems.gd"), _get_systems_logic_source())
_write_file(scripts_path.path_join("PrefabDeckBuilder.gd"), _get_deck_builder_source())
_write_file(scripts_path.path_join("FirstPersonPlayer.gd"), _get_player_controller_source())
They will generate:
res://scripts/ShipSystems.gd
res://scripts/PrefabDeckBuilder.gd
res://scripts/FirstPersonPlayer.gd
If you're fixing the previous parser error
The important part is that the string returned by _get_deck_builder_source() must be terminated correctly.
For example, if this is the final generated line:
func _get_deck_builder_source() -> String:
	return \
		"extends Node3D\n" + \
		"..." + \
		"		interior_dressing_instance.prefab_limit = 256\n"
Do not end it with:
"		interior_dressing_instance.prefab_limit = 256\n" + \
because that leaves a + waiting for another expression.
Also, if you want the created interior dressing node actually attached to the ship, the generated source should continue with:
"		deck_root_node.add_child(interior_dressing_instance)\n"
So the ending would be:
		"		interior_dressing_instance.name = \"Automated_Modular_Interior_Dressing\"\n" + \
		"		interior_dressing_instance.prefab_limit = 256\n" + \
		"		deck_root_node.add_child(interior_dressing_instance)\n"
That is likely the correct structure for your PrefabDeckBuilder.gd generator.
I see the problem. That final + \ is the parser error. You are building one long GDScript string, so the last line needs to end the string instead of asking for another expression.
Replace your section with:
	"		box_geom.size = deck_bounds_dimensions\n" + \
	"		col_shape.shape = box_geom\n" + \
	"		static_body.add_child(col_shape)\n" + \
	"		var visual_mesh := MeshInstance3D.new()\n" + \
	"		var primitive := BoxMesh.new()\n" + \
	"		primitive.size = deck_bounds_dimensions\n" + \
	"		visual_mesh.mesh = primitive\n" + \
	"		static_body.add_child(visual_mesh)\n" + \
	"		deck_root_node.add_child(static_body)\n" + \
	"	if modular_interior_dressing_class:\n" + \
	"		var interior_dressing_instance = modular_interior_dressing_class.new()\n" + \
	"		interior_dressing_instance.name = \"Automated_Modular_Interior_Dressing\"\n" + \
	"		interior_dressing_instance.prefab_limit = 256\n"
The important change
You currently have:
"		interior_dressing_instance.prefab_limit = 256\n" + \
Change it to:
"		interior_dressing_instance.prefab_limit = 256\n"
However, if there are more generated lines after this, then you do need + \ there, and the next line must immediately provide another string:
	"		interior_dressing_instance.prefab_limit = 256\n" + \
	"		deck_root_node.add_child(interior_dressing_instance)\n"
For your interior-dressing system, I'd expect that second version is actually what you want, because otherwise the newly created interior_dressing_instance isn't added to the scene tree.
Yes — that error is caused by the + \ being left at the end of the expression.
If this is inside a GDScript string-building section, use:
"		interior_dressing_instance.prefab_limit = 96\n" +
only if another string immediately follows, e.g.:
var script_text := \
	"extends Node3D\n" +
	"\n" +
	"func _ready() -> void:\n" +
	"	interior_dressing_instance.prefab_limit = 96\n"
But if line 202 is the final string, remove the + entirely:
"		interior_dressing_instance.prefab_limit = 96\n"
Most likely fix
If your code currently ends like this:
"		interior_dressing_instance.prefab_limit = 96\n" + \
change it to:
"		interior_dressing_instance.prefab_limit = 96\n"
The important distinction is:
+ means another expression/string must follow
\ does not belong there when you're already using GDScript's normal multiline expression syntax
If you paste lines 190–210, I can correct the exact section so you don't get another parser error.
If you’re adding that line to a generated Godot/C#-style string, the escaped form is:
"		interior_dressing_instance.prefab_limit = 96\n" + \
If this is GDScript, the \ at the end means “continue this expression on the next line.”
If you’re trying to increase the prefab limit for the massive ship/interior system, 96 can simply be changed, for example:
"		interior_dressing_instance.prefab_limit = 256\n" + \
Or, for a very large capital ship:
"		interior_dressing_instance.prefab_limit = 512\n" + \
96 = moderate, 256 = large, 512 = very large.
  Done — I expanded the supplied Spherocal project into a large Godot 4 capital-ship framework.
Included
Massive ~1.6 km × 2.37 km × 426 m hull scale
12 procedural decks
Forward and aft hangars
Engineering/reactor/command areas
Automatic Sci-Fi_Starter_Kit .tscn prefab discovery and placement
Ship systems manager
Massive-ship controller
Procedural interior/deck builder
Hull panel/emission shader
Energy-field shader
Reactor glow shader
Ready-to-run project.godot
README with setup instructions
Put your Sci-Fi_Starter_Kit folder beside spherocal/ in the project. The prefab loader will automatically scan it and populate the ship.
Download the complete Godot project:
Download Spherocal Massive Sci-Fi Ship
Done — I created a runnable Godot 4 starter project for HYPERSPACE // INTERLUDE, including:
Glowing cinematic loading/menu artwork
Main menu with working buttons
New Game / Continue / Load Game
Save/load system
Procedural 64-system TOME universe
Player ship flight foundation
Boost system
Combat manager foundation
Resource/credits system
HUD
Neon glow shader
Organized Godot folder structure
Development roadmap and feature architecture
Download
Download Hyperspace Interlude — Godot Starter ZIP
Open the extracted Hyperspace_Interlude_Godot folder in Godot 4 and press Run Project.
This is structured as the foundation we can build into the much larger game: 3D ships → procedural planets → mining → factions → missions → hyperspace combat → ship designer → AI/creator system → full TOME universe.
Yes — I’d make Hyperspace Interlude the core identity and lean into the contrast rather than treating the two genres as separate games.
Recommended structure
Normal space → Exploration
Explore procedurally generated systems.
Mine and collect resources.
Discover planets, anomalies, ruins, stations and hidden locations.
Upgrade/customize the ship.
Build relationships with factions/NPCs.
Prepare for the next jump.
Hyperspace → Action
Enter hyperspace to travel between distant systems.
Hyperspace isn't simply a loading screen: it becomes a dangerous playable environment.
Enemies, anomalies and hostile fleets can intercept you.
The player fights through the encounter while trying to maintain the jump.
Surviving brings you into the next system.
Then → Interlude The important part is the emotional rhythm:
Explore → prepare → jump → fight → survive → arrive → breathe → explore again.
That makes Interlude more than a title. It describes the game's pacing.
The title treatment I'd use
HYPERSPACE // INTERLUDE
Tagline:
Survive the chaos. Discover the quiet.
And underneath that, a smaller line could say:
A universe between battles.
It also fits your existing Skull Cap/Tome concept
You could make Hyperspace Interlude the actual game, while the technology you've been designing for Skull Cap becomes the underlying procedural/AI game framework.
For example:
HYPERSPACE // INTERLUDE
        │
        ├── TOME UNIVERSE
        │     ├── Galaxies
        │     ├── Solar Systems
        │     ├── Planets
        │     ├── Moons
        │     ├── Stations
        │     └── Civilizations
        │
        ├── EXPLORATION
        │     ├── Mining
        │     ├── Trading
        │     ├── Discovery
        │     └── Ship Building
        │
        ├── HYPERSPACE
        │     ├── Combat
        │     ├── Interdiction
        │     ├── Anomalies
        │     └── Survival
        │
        └── AI / MODDING
              ├── Create ships
              ├── Create worlds
              ├── Create missions
              └── Modify the universe
That gives you a very strong game identity: the player isn't constantly fighting, but the peaceful sections aren't just filler between combat either. The quiet periods become something the player actually wants to return to.
If you want, I can also �⁠turn this into a full Hyperspace Interlude game design document with the universe, factions, ships, weapons, hyperspace mechanics, exploration loop, progression, AI systems, and opening storyline.
That code is JavaScript/Node.js, not GDScript. You can't paste it directly into a Godot .gd script.
For your Godot 4 + Ollama + Qwen2.5-Coder setup, use Godot's HTTPRequest to call Ollama's local API instead:
extends Node

const OLLAMA_URL := "http://127.0.0.1:11434/api/chat"
const MODEL := "qwen2.5-coder:7b"

var http: HTTPRequest

func _ready() -> void:
	http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_request_completed)

	send_message("Hello!")


func send_message(message: String) -> void:
	var body := {
		"model": MODEL,
		"messages": [
			{
				"role": "user",
				"content": message
			}
		],
		"stream": false
	}

	var json_body := JSON.stringify(body)

	var headers := [
		"Content-Type: application/json"
	]

	var error := http.request(
		OLLAMA_URL,
		headers,
		HTTPClient.METHOD_POST,
		json_body
	)

	if error != OK:
		push_error("Failed to send request: %s" % error)


func _on_request_completed(
	result: int,
	response_code: int,
	_headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Ollama connection failed: %s" % result)
		return

	if response_code != 200:
		push_error(
			"Ollama returned HTTP %d: %s"
			% [response_code, body.get_string_from_utf8()]
		)
		return

	var response = JSON.parse_string(body.get_string_from_utf8())

	if response == null:
		push_error("Invalid JSON returned by Ollama")
		return

	if response.has("message"):
		print(response["message"]["content"])
This replaces your JavaScript
Your Node.js code:
const response = await ollama.chat({
  model: 'qwen2.5-coder:7b',
  messages: [{role: 'user', content: 'Hello!'}],
})
becomes essentially:
send_message("Hello!")
with Godot talking directly to:
http://127.0.0.1:11434/api/chat
Important for your Chromebook setup
If Ollama is running somewhere other than the same machine as Godot, 127.0.0.1 will be wrong. You would need the Ollama machine's LAN address, for example:
const OLLAMA_URL := "http://192.168.1.50:11434/api/chat"
Also make sure the model exists:
qwen2.5-coder:7b
Your earlier CustomLLMInterface code can then sit on top of this HTTP layer, rather than trying to execute the JavaScript import ollama code inside Godot.
If this is for your Godot 4 AI Hub / Ollama setup, the main issue is that CustomLLMInterface must actually exist and be loaded before you instantiate it.
A safer Godot 4 version is:
var provider_res = load("res://addons/ai_assistant_hub/providers/custom_provider.tres")

if provider_res == null:
	push_error("Could not load custom_provider.tres")
	return

var llm_interface = CustomLLMInterface.new(provider_res)

llm_interface.model = "qwen2.5-coder:7b"
llm_interface.tools_enabled = true
However, this alone won't work if CustomLLMInterface isn't a globally registered class or explicitly preloaded.
For example, if the class is in:
res://addons/ai_assistant_hub/providers/custom_llm_interface.gd
use:
const CustomLLMInterface = preload(
	"res://addons/ai_assistant_hub/providers/custom_llm_interface.gd"
)

var provider_res = load(
	"res://addons/ai_assistant_hub/providers/custom_provider.tres"
)

if provider_res == null:
	push_error("Failed to load custom_provider.tres")
	return

var llm_interface = CustomLLMInterface.new(provider_res)

llm_interface.model = "qwen2.5-coder:7b"
llm_interface.tools_enabled = true
If you're getting an error such as "Identifier CustomLLMInterface not declared", this is the fix I'd use. If you paste your custom_llm_interface.gd and custom_provider.tres, I can correct the whole Ollama provider so qwen2.5-coder:7b works properly in Godot 4.
Yes — those errors are from the version I gave you. The key issue is that I accidentally turned the answer into a malformed script block, and I also changed the inheritance structure unnecessarily.
Do not append my previous version underneath your existing LLMInterface.gd. Replace the entire file with the corrected version below.
The most important fixes are:
@tool is first.
class_name and extends are in the correct order.
No duplicate provider functions.
No recursive property setters.
No invalid return: syntax.
Keeps your existing AI Hub architecture.
Keeps OllamaTurboAPI compatible with it.
Replace LLMInterface.gd completely
Writing
@tool
class_name LLMInterface
extends RefCounted


signal model_changed(model: String)
signal override_temperature_changed(value: bool)
signal temperature_changed(temperature: float)
signal reasoning_changed(reasoning: String)
signal tools_enabled_changed(value: bool)
signal llm_config_changed
signal context_usage_updated(max: int, current: int)


enum Capabilities {
	Tools,
	ReasoningLevels
}


enum ToolPayloadParts {
	Name,
	Description,
	Parameters,
	RequiredParams
}


enum ParamPayloadParts {
	Name,
	Description,
	Type,
	Enum
}


const AI_TOOL_OPTION_EXTENDED_PROMPT = preload(
	"res://addons/ai_assistant_hub/tools/general_params_and_options/ai_tool_option_extended_prompt.tres"
)

const TOOL_DEFAULT_ACCESS_PROFILE = preload(
	"res://addons/ai_assistant_hub/tools/access_profiles/default_access.tres"
)

const TOOL_CUSTOM_ACCESS_PATH := "res://addons/ai_assistant_hub/tools/access_profiles/custom_access.tres"


const TOOL_PAYLOAD_KEYWORDS := {
	ToolPayloadParts.Name: "<:NAME:>",
	ToolPayloadParts.Description: "<:DESC:>",
	ToolPayloadParts.Parameters: "<:PARAM:>",
	ToolPayloadParts.RequiredParams: "<:REQP:>"
}


const PARAM_PAYLOAD_KEYWORDS := {
	ParamPayloadParts.Name: "<:NAME:>",
	ParamPayloadParts.Description: "<:DESC:>",
	ParamPayloadParts.Type: "<:TYPE:>",
	ParamPayloadParts.Enum: "<:ENUM:>"
}


const INVALID_RESPONSE := "[INVALID_RESPONSE]"


# -------------------------------------------------------------------
# Public properties
# -------------------------------------------------------------------

var _model: String = ""
var _override_temperature: bool = false
var _temperature: float = 0.7
var _reasoning: String = ""
var _tools_enabled: bool = false
var _context_length: int = 0


var model: String:
	get:
		return _model
	set(value):
		if _model == value:
			return

		_model = value
		_max_context = 0
		_current_context = 0

		context_usage_updated.emit(0, 0)
		model_changed.emit(value)


var override_temperature: bool:
	get:
		return _override_temperature
	set(value):
		if _override_temperature == value:
			return

		_override_temperature = value
		override_temperature_changed.emit(value)


var temperature: float:
	get:
		return _temperature
	set(value):
		if is_equal_approx(_temperature, value):
			return

		_temperature = value
		temperature_changed.emit(value)


var reasoning: String:
	get:
		return _reasoning
	set(value):
		if _reasoning == value:
			return

		_reasoning = value
		reasoning_changed.emit(value)


var tools_enabled: bool:
	get:
		return _tools_enabled
	set(value):
		if _tools_enabled == value:
			return

		_tools_enabled = value
		tools_enabled_changed.emit(value)


var context_length: int:
	get:
		return _context_length
	set(value):
		_context_length = value


# -------------------------------------------------------------------
# Internal variables
# -------------------------------------------------------------------

var _msg_cleaner := ResponseCleaner.new()

var _base_url: String = ""
var _models_url: String = ""
var _chat_url: String = ""
var _max_context_url: String = ""
var _capabilities_url: String = ""

var _api_key: String = ""

var _llm_provider: LLMProviderResource

var _max_context: int = 0
var _current_context: int = 0

var _available_tools: Dictionary = {}
var _manual_approval_tool_ids: Array[String] = []
var _tools_payload: Array = []

var _tool_undo_queue := AIToolUndoQueue.new()
var _global_tool_option_values: Dictionary = {}

var _supports_reasoning_levels: bool = false
var _supports_tools: bool = false


# -------------------------------------------------------------------
# Tool access class
# -------------------------------------------------------------------

class ToolWithAccess:

	var tool_definition: AIToolResource
	var tool_access: AIToolAccess


	func _init(
		_tool_definition: AIToolResource,
		_tool_access: AIToolAccess
	) -> void:

		tool_definition = _tool_definition
		tool_access = _tool_access


# -------------------------------------------------------------------
# Initialization
# -------------------------------------------------------------------

func _init(llm_provider: LLMProviderResource) -> void:

	if llm_provider == null:
		AIHubPlugin.print_err(
			"Cannot initialize the LLM interface without a provider."
		)
		return

	_llm_provider = llm_provider

	load_llm_parameters()

	_initialize()


func get_llm_provider() -> LLMProviderResource:
	return _llm_provider


func load_llm_parameters() -> void:

	if _llm_provider == null:
		return

	var config := LLMConfigManager.new(
		_llm_provider.api_id
	)


	if _llm_provider.fix_url.is_empty():

		var custom_url := config.load_url()

		if custom_url.is_empty():
			_base_url = _llm_provider.default_url
		else:
			_base_url = custom_url

	else:

		_base_url = _llm_provider.fix_url


	_base_url = _base_url.trim_suffix("/")


	_models_url = (
		_base_url +
		_llm_provider.models_url_postfix
	)

	_chat_url = (
		_base_url +
		_llm_provider.chat_url_postfix
	)

	_max_context_url = (
		_base_url +
		_llm_provider.max_context_url_postfix
	)

	_capabilities_url = (
		_base_url +
		_llm_provider.capabilities_url_postfix
	)

	_api_key = config.load_key()

	llm_config_changed.emit()


# -------------------------------------------------------------------
# JSON helper
# -------------------------------------------------------------------

func get_full_response(body: PackedByteArray) -> Variant:

	var text := body.get_string_from_utf8()

	var json := JSON.new()

	var parse_result := json.parse(text)

	if parse_result != OK:

		AIHubPlugin.print_err(
			"Failed to parse JSON in get_full_response: %s"
			% json.get_error_message()
		)

		return text


	var data = json.get_data()

	if data is Dictionary:
		return data


	AIHubPlugin.print_err(
		"Parsed JSON response is not a Dictionary in get_full_response."
	)

	return text


# -------------------------------------------------------------------
# Context
# -------------------------------------------------------------------

func check_context_usage(http_request: HTTPRequest) -> void:

	if _max_context > 0:

		context_usage_updated.emit(
			_max_context,
			_current_context
		)

	else:

		detect_max_context(http_request)


# -------------------------------------------------------------------
# Capabilities
# -------------------------------------------------------------------

func load_capabilities(
	model_capabilities: Array[Capabilities],
	tool_access: AIToolAccessProfile
) -> void:

	AIHubPlugin.print_msg(
		"Loading model capabilities."
	)

	_supports_reasoning_levels = false
	_supports_tools = false


	for capability in model_capabilities:

		match capability:

			Capabilities.ReasoningLevels:
				_supports_reasoning_levels = true

			Capabilities.Tools:
				_supports_tools = true


	if not _supports_tools:
		return


	if tool_access == null:
		tool_access = TOOL_DEFAULT_ACCESS_PROFILE


	_global_tool_option_values = (
		tool_access.get_global_option_values()
	)

	_available_tools.clear()
	_manual_approval_tool_ids.clear()


	for key in tool_access.permissions:

		var tool_definition: AIToolResource = key
		var access: AIToolAccess = tool_access.permissions[key]


		if access.usage_permission != AIToolAccess.Permission.Hide:

			_available_tools[tool_definition.id] = (
				ToolWithAccess.new(
					tool_definition,
					access
				)
			)


			if (
				access.usage_permission ==
				AIToolAccess.Permission.Ask
			):

				_manual_approval_tool_ids.append(
					tool_definition.id
				)


	_tools_payload = _build_tools_payload()


# -------------------------------------------------------------------
# Tool permissions
# -------------------------------------------------------------------

func get_permission_for_tool(
	tool_id: String
) -> AIToolAccess.Permission:

	if _manual_approval_tool_ids.has(tool_id):
		return AIToolAccess.Permission.Ask


	if _available_tools.has(tool_id):
		return AIToolAccess.Permission.Allow


	return AIToolAccess.Permission.Hide


func get_tool_instance(tool_id: String) -> AITool:

	if not _available_tools.has(tool_id):

		AIHubPlugin.print_err(
			"Requested tool is unavailable: %s"
			% tool_id
		)

		return null


	var tool_data: ToolWithAccess = (
		_available_tools.get(tool_id)
	)


	if tool_data == null:
		return null


	var option_values := {}

	var tool_opt_values := (
		tool_data.tool_access.option_values
	)


	for option in tool_data.tool_definition.options:

		var option_id := option.id

		var in_global := (
			_global_tool_option_values.has(option_id)
			and
			_global_tool_option_values[option_id] != null
		)

		var in_tool := (
			tool_opt_values.has(option_id)
			and
			tool_opt_values[option_id] != null
		)


		if (
			in_tool
			and
			in_global
			and
			(
				option.type ==
				AIToolOption.OptionType.ArrayOfProjectDir
				or
				option.type ==
				AIToolOption.OptionType.ArrayOfProjectFiles
			)
		):

			var combined_value := []

			combined_value.append_array(
				tool_opt_values[option_id]
			)

			combined_value.append_array(
				_global_tool_option_values[option_id]
			)

			option_values[option_id] = combined_value


		elif in_global:

			option_values[option_id] = (
				_global_tool_option_values[option_id]
			)


		elif in_tool:

			option_values[option_id] = (
				tool_opt_values[option_id]
			)


	var tool: AITool = (
		tool_data.tool_definition.create_instance(
			option_values,
			_tool_undo_queue
		)
	)


	if tool:
		return tool


	AIHubPlugin.print_err(
		"Failed to create an instance of tool %s."
		% tool_id
	)

	return null


# -------------------------------------------------------------------
# Provider methods
#
# Child classes override these.
# -------------------------------------------------------------------

func send_get_models_request(
	http_request: HTTPRequest
) -> bool:

	return false


func read_models_response(
	body: PackedByteArray
) -> Array[String]:

	return [INVALID_RESPONSE]


func send_chat_request(
	http_request: HTTPRequest,
	content: Array
) -> bool:

	return false


func read_response(
	body: PackedByteArray
) -> AIAssistantResponse:

	return null


func detect_max_context(
	http_request: HTTPRequest
) -> void:

	return


func read_max_context_http_response(
	body: PackedByteArray
) -> void:

	return


func send_get_capabilities_request(
	http_request: HTTPRequest,
	model_name: String
) -> bool:

	return false


func read_capabilities_response(
	body: PackedByteArray
) -> Array[Capabilities]:

	return []


# -------------------------------------------------------------------
# Optional initialization hook
# -------------------------------------------------------------------

func _initialize() -> void:
	return


# -------------------------------------------------------------------
# Tool payload generation
# -------------------------------------------------------------------

func _build_tools_payload() -> Array:

	var tool_parts: Array[String] = []


	for tool_data in _available_tools.values():

		var tool: AITool = (
			tool_data.tool_definition.create_instance(
				tool_data.tool_access.option_values,
				_tool_undo_queue
			)
		)


		if tool == null:

			AIHubPlugin.print_err(
				"Failed to create an instance of tool "
				+ "%s. The tool will be omitted from the payload."
				% tool_data.tool_definition.id
			)

			continue


		var parameters_definition := (
			tool.get_parameters()
		)

		var parameters: Array[String] = []
		var required_parameters: Array[String] = []

		var failed := false


		for parameter in parameters_definition:

			if parameter.required:

				required_parameters.append(
					parameter.name
				)


			var parameter_payload := (
				_build_parameter_payload(parameter)
			)


			if parameter_payload.is_empty():

				AIHubPlugin.print_err(
					"Tool %s cannot be used because "
					+ "parameter %s is invalid."
					% [
						tool.get_function_name(),
						parameter.name
					]
				)

				failed = true
				break


			parameters.append(
				parameter_payload
			)


		var access: AIToolAccess = (
			tool_data.tool_access
		)


		var tool_description: String


		if access.option_values.has(
			AI_TOOL_OPTION_EXTENDED_PROMPT.id
		):

			tool_description = (
				"%s\n\n*Important instructions:*\n%s"
				% [
					tool.get_description(),
					access.option_values[
						AI_TOOL_OPTION_EXTENDED_PROMPT.id
					]
				]
			)

		else:

			tool_description = tool.get_description()


		if not failed:

			var function_data := {
				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.Name
				]:
					tool.get_function_name(),

				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.Description
				]:
					tool_description.json_escape(),

				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.Parameters
				]:
					",\n".join(parameters),

				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.RequiredParams
				]:
					required_parameters
			}


			tool_parts.append(
				_llm_provider.tool_payload_template.format(
					function_data
				)
			)


	var payload_string := (
		"[\n%s\n]"
		% ",".join(tool_parts)
	)


	var payload := JSON.new()

	var error := payload.parse(
		payload_string
	)


	if error == OK:
		return payload.get_data()


	AIHubPlugin.print_err(
		"Tool JSON payload is invalid. "
		+ "Error: %s at line %d.\nFull payload:\n%s"
		% [
			payload.get_error_message(),
			payload.get_error_line(),
			payload_string
		]
	)

	return []


# -------------------------------------------------------------------
# Parameter payload
# -------------------------------------------------------------------

func _build_parameter_payload(
	parameter: AIToolParameter
) -> String:

	var type := (
		_get_parameter_type_payload_name(
			parameter.type
		)
	)


	if type.is_empty():

		AIHubPlugin.print_err(
			"Parameter type %s is not supported."
			% AIToolParameter.ParameterType.find_key(
				parameter.type
			)
		)

		return ""


	var param_data := {
		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Name
		]:
			parameter.name,

		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Description
		]:
			parameter.description.json_escape(),

		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Type
		]:
			type
	}


	var parameter_payload_template := (
		_llm_provider.tool_param_payload_template
	)


	var enum_key := (
		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Enum
		]
	)


	if parameter.type == AIToolParameter.ParameterType.StringEnum:

		param_data[enum_key] = (
			parameter.string_enum_valid_values
		)

	else:

		parameter_payload_template = (
			_remove_line_with_substring(
				parameter_payload_template,
				enum_key
			)
		)


	return parameter_payload_template.format(
		param_data
	)


# -------------------------------------------------------------------
# Parameter type mapping
# -------------------------------------------------------------------

func _get_parameter_type_payload_name(
	parameter_type: AIToolParameter.ParameterType
) -> String:

	var name: String = ""


	match parameter_type:

		AIToolParameter.ParameterType.Int:
			name = _llm_provider.tool_param_type_int

		AIToolParameter.ParameterType.Float:
			name = _llm_provider.tool_param_type_float

		AIToolParameter.ParameterType.Boolean:
			name = _llm_provider.tool_param_type_boolean

		AIToolParameter.ParameterType.String:
			name = _llm_provider.tool_param_type_string

		AIToolParameter.ParameterType.Code:
			name = _llm_provider.tool_param_type_string

		AIToolParameter.ParameterType.StringEnum:
			name = _llm_provider.tool_param_type_string

		AIToolParameter.ParameterType.Array:
			name = _llm_provider.tool_param_type_array


	return name


# -------------------------------------------------------------------
# Utility
# -------------------------------------------------------------------

func _remove_line_with_substring(
	original_text: String,
	substring: String
) -> String:

	var lines := original_text.split("\n")
	var filtered_lines: Array[String] = []


	for line in lines:

		if not line.contains(substring):
			filtered_lines.append(line)


	return "\n".join(filtered_lines)
Then keep OllamaTurboAPI.gd as a separate file
Do not paste the Ollama functions into LLMInterface.gd.
Your project should have:
addons/
└── ai_assistant_hub/
    └── llm/
        ├── LLMInterface.gd
        └── OllamaTurboAPI.gd
The important relationship is:
LLMInterface
     ▲
     │ extends
     │
OllamaTurboAPI
So these errors:
Function "send_chat_request" has the same name
Function "read_response" has the same name
Function "_initialize" has the same name
happen when the child implementation has accidentally been pasted into the same script twice.
Also, don't add extends RefCounted if your original AI Hub LLMInterface deliberately inherits from something else. If the corrected file above produces an inheritance/type error, send me the exact first error and the LLMProviderResource.gd file; that will let me match this to your actual AI Hub version instead of guessing.
Yes — with this LLMInterface, I can see exactly how your OllamaTurboAPI is supposed to plug in.
There is one major issue in the base class that I would fix before changing the Ollama provider: the property setters recursively assign to themselves.
For example:
var model: String:
	set(value):
		model = value
That setter calls the setter again. The same problem exists for override_temperature, temperature, reasoning, and context_length.
Use backing variables instead.
Corrected LLMInterface.gd
Writing
@tool
class_name LLMInterface
extends RefCounted

# Base interface for all LLM providers used by AI Assistant Hub.


signal model_changed(model: String)
signal override_temperature_changed(value: bool)
signal temperature_changed(temperature: float)
signal reasoning_changed(reasoning: String)
signal tools_enabled_changed(value: bool)
signal llm_config_changed
signal context_usage_updated(max: int, current: int)


enum Capabilities {
	Tools,
	ReasoningLevels
}


enum ToolPayloadParts {
	Name,
	Description,
	Parameters,
	RequiredParams
}


enum ParamPayloadParts {
	Name,
	Description,
	Type,
	Enum
}


const AI_TOOL_OPTION_EXTENDED_PROMPT = preload(
	"res://addons/ai_assistant_hub/tools/general_params_and_options/ai_tool_option_extended_prompt.tres"
)

const TOOL_DEFAULT_ACCESS_PROFILE: AIToolAccessProfile = preload(
	"res://addons/ai_assistant_hub/tools/access_profiles/default_access.tres"
)

const TOOL_CUSTOM_ACCESS_PATH := (
	"res://addons/ai_assistant_hub/tools/access_profiles/custom_access.tres"
)


const TOOL_PAYLOAD_KEYWORDS := {
	ToolPayloadParts.Name: "<:NAME:>",
	ToolPayloadParts.Description: "<:DESC:>",
	ToolPayloadParts.Parameters: "<:PARAM:>",
	ToolPayloadParts.RequiredParams: "<:REQP:>"
}


const PARAM_PAYLOAD_KEYWORDS := {
	ParamPayloadParts.Name: "<:NAME:>",
	ParamPayloadParts.Description: "<:DESC:>",
	ParamPayloadParts.Type: "<:TYPE:>",
	ParamPayloadParts.Enum: "<:ENUM:>"
}


const INVALID_RESPONSE := "[INVALID_RESPONSE]"


# -------------------------------------------------------------------------
# Public configuration properties
# -------------------------------------------------------------------------

var _model: String = ""
var _override_temperature: bool = false
var _temperature: float = 0.7
var _reasoning: String = ""
var _tools_enabled: bool = false
var _context_length: int = 0


var model: String:
	get:
		return _model
	set(value):
		if _model == value:
			return

		_model = value
		_max_context = 0
		_current_context = 0

		context_usage_updated.emit(0, 0)
		model_changed.emit(value)


var override_temperature: bool:
	get:
		return _override_temperature
	set(value):
		if _override_temperature == value:
			return

		_override_temperature = value
		override_temperature_changed.emit(value)


var temperature: float:
	get:
		return _temperature
	set(value):
		if is_equal_approx(_temperature, value):
			return

		_temperature = value
		temperature_changed.emit(value)


var reasoning: String:
	get:
		return _reasoning
	set(value):
		if _reasoning == value:
			return

		_reasoning = value
		reasoning_changed.emit(value)


var tools_enabled: bool:
	get:
		return _tools_enabled
	set(value):
		if _tools_enabled == value:
			return

		_tools_enabled = value
		tools_enabled_changed.emit(value)


var context_length: int:
	get:
		return _context_length
	set(value):
		_context_length = value


# -------------------------------------------------------------------------
# Internal provider state
# -------------------------------------------------------------------------

var _msg_cleaner := ResponseCleaner.new()

var _base_url: String = ""
var _models_url: String = ""
var _chat_url: String = ""
var _max_context_url: String = ""
var _capabilities_url: String = ""

var _api_key: String = ""

var _llm_provider: LLMProviderResource

var _max_context: int = 0
var _current_context: int = 0

var _available_tools: Dictionary = {}
var _manual_approval_tool_ids: Array[String] = []
var _tools_payload: Array = []

var _tool_undo_queue := AIToolUndoQueue.new()
var _global_tool_option_values: Dictionary = {}

var _supports_reasoning_levels: bool = false
var _supports_tools: bool = false


# -------------------------------------------------------------------------
# Tool access wrapper
# -------------------------------------------------------------------------

class ToolWithAccess:
	var tool_definition: AIToolResource
	var tool_access: AIToolAccess

	func _init(
		_tool_definition: AIToolResource,
		_tool_access: AIToolAccess
	) -> void:
		tool_definition = _tool_definition
		tool_access = _tool_access


# -------------------------------------------------------------------------
# Initialization
# -------------------------------------------------------------------------

func _init(llm_provider: LLMProviderResource) -> void:
	if llm_provider == null:
		AIHubPlugin.print_err(
			"Tried to create LLM instance with no provider."
		)
		return

	_llm_provider = llm_provider

	load_llm_parameters()
	_initialize()


func get_llm_provider() -> LLMProviderResource:
	return _llm_provider


func load_llm_parameters() -> void:
	if _llm_provider == null:
		return

	var config := LLMConfigManager.new(
		_llm_provider.api_id
	)

	if _llm_provider.fix_url.is_empty():
		var custom_url := config.load_url()

		if custom_url.is_empty():
			_base_url = _llm_provider.default_url
		else:
			_base_url = custom_url
	else:
		_base_url = _llm_provider.fix_url


	# Remove accidental trailing slash.
	_base_url = _base_url.trim_suffix("/")


	_models_url = (
		_base_url +
		_llm_provider.models_url_postfix
	)

	_chat_url = (
		_base_url +
		_llm_provider.chat_url_postfix
	)

	_max_context_url = (
		_base_url +
		_llm_provider.max_context_url_postfix
	)

	_capabilities_url = (
		_base_url +
		_llm_provider.capabilities_url_postfix
	)

	_api_key = config.load_key()

	llm_config_changed.emit()


# -------------------------------------------------------------------------
# Generic JSON response helper
# -------------------------------------------------------------------------

func get_full_response(body: PackedByteArray) -> Variant:
	var text := body.get_string_from_utf8()

	var json := JSON.new()
	var parse_result := json.parse(text)

	if parse_result != OK:
		AIHubPlugin.print_err(
			"Failed to parse JSON in get_full_response: %s"
			% json.get_error_message()
		)

		return text


	var data = json.get_data()

	if data is Dictionary:
		return data


	AIHubPlugin.print_err(
		"Parsed JSON is not a Dictionary in get_full_response."
	)

	return text


# -------------------------------------------------------------------------
# Context
# -------------------------------------------------------------------------

func check_context_usage(http_request: HTTPRequest) -> void:
	if _max_context > 0:
		context_usage_updated.emit(
			_max_context,
			_current_context
		)
	else:
		detect_max_context(http_request)


# -------------------------------------------------------------------------
# Capabilities
# -------------------------------------------------------------------------

func load_capabilities(
	model_capabilities: Array[Capabilities],
	tool_access: AIToolAccessProfile
) -> void:

	AIHubPlugin.print_msg(
		"Loading capabilities."
	)

	_supports_reasoning_levels = false
	_supports_tools = false


	if model_capabilities:
		for capability in model_capabilities:
			match capability:
				Capabilities.ReasoningLevels:
					_supports_reasoning_levels = true

				Capabilities.Tools:
					_supports_tools = true


	if not _supports_tools:
		return

	if tool_access == null:
		tool_access = TOOL_DEFAULT_ACCESS_PROFILE


	_global_tool_option_values = (
		tool_access.get_global_option_values()
	)

	_available_tools.clear()
	_manual_approval_tool_ids.clear()


	for key in tool_access.permissions:
		var tool_definition: AIToolResource = key
		var access: AIToolAccess = tool_access.permissions[key]

		if access.usage_permission != AIToolAccess.Permission.Hide:

			_available_tools[tool_definition.id] = (
				ToolWithAccess.new(
					tool_definition,
					access
				)
			)

			if (
				access.usage_permission ==
				AIToolAccess.Permission.Ask
			):
				_manual_approval_tool_ids.append(
					tool_definition.id
				)


	_tools_payload = _build_tools_payload()


# -------------------------------------------------------------------------
# Tool permissions
# -------------------------------------------------------------------------

func get_permission_for_tool(
	tool_id: String
) -> AIToolAccess.Permission:

	if _manual_approval_tool_ids.has(tool_id):
		return AIToolAccess.Permission.Ask

	if _available_tools.has(tool_id):
		return AIToolAccess.Permission.Allow

	return AIToolAccess.Permission.Hide


func get_tool_instance(tool_id: String) -> AITool:
	if not _available_tools.has(tool_id):
		AIHubPlugin.print_err(
			"Requested unavailable tool: %s"
			% tool_id
		)

		return null


	var tool_data: ToolWithAccess = (
		_available_tools.get(tool_id)
	)

	if tool_data == null:
		return null


	var option_values := {}

	var tool_opt_values := (
		tool_data.tool_access.option_values
	)


	for option in tool_data.tool_definition.options:
		var option_id := option.id

		var in_global := (
			_global_tool_option_values.has(option_id)
			and
			_global_tool_option_values[option_id] != null
		)

		var in_tool := (
			tool_opt_values.has(option_id)
			and
			tool_opt_values[option_id] != null
		)


		if (
			in_tool
			and
			in_global
			and
			(
				option.type ==
				AIToolOption.OptionType.ArrayOfProjectDir
				or
				option.type ==
				AIToolOption.OptionType.ArrayOfProjectFiles
			)
		):
			var combined_value := []

			combined_value.append_array(
				tool_opt_values[option_id]
			)

			combined_value.append_array(
				_global_tool_option_values[option_id]
			)

			option_values[option_id] = combined_value

		elif in_global:
			option_values[option_id] = (
				_global_tool_option_values[option_id]
			)

		elif in_tool:
			option_values[option_id] = (
				tool_opt_values[option_id]
			)


	var tool: AITool = (
		tool_data.tool_definition.create_instance(
			option_values,
			_tool_undo_queue
		)
	)


	if tool:
		return tool


	AIHubPlugin.print_err(
		"An error occurred when creating an instance of tool %s."
		% tool_id
	)

	return null


# -------------------------------------------------------------------------
# Provider methods
# These are intentionally overridden by provider classes.
# -------------------------------------------------------------------------

func send_get_models_request(
	http_request: HTTPRequest
) -> bool:
	return false


func read_models_response(
	body: PackedByteArray
) -> Array[String]:

	return [INVALID_RESPONSE]


func send_chat_request(
	http_request: HTTPRequest,
	content: Array
) -> bool:

	return false


func read_response(
	body: PackedByteArray
) -> AIAssistantResponse:

	return null


func detect_max_context(
	http_request: HTTPRequest
) -> void:
	return


func read_max_context_http_response(
	body: PackedByteArray
) -> void:
	return


func send_get_capabilities_request(
	http_request: HTTPRequest,
	model_name: String
) -> bool:

	return false


func read_capabilities_response(
	body: PackedByteArray
) -> Array[Capabilities]:

	return []


# -------------------------------------------------------------------------
# Provider initialization hook
# -------------------------------------------------------------------------

func _initialize() -> void:
	return


# -------------------------------------------------------------------------
# Tool payload generation
# -------------------------------------------------------------------------

func _build_tools_payload() -> Array:
	var tool_parts: Array[String] = []


	for tool_data in _available_tools.values():

		var tool: AITool = (
			tool_data.tool_definition.create_instance(
				tool_data.tool_access.option_values,
				_tool_undo_queue
			)
		)


		if tool == null:
			AIHubPlugin.print_err(
				"An error occurred when creating an instance "
				+ "of tool %s. Tool skipped from payload."
				% tool_data.tool_definition.id
			)

			continue


		var parameters_definition := (
			tool.get_parameters()
		)

		var parameters: Array[String] = []
		var required_parameters: Array[String] = []

		var failed := false


		for parameter in parameters_definition:

			if parameter.required:
				required_parameters.append(
					parameter.name
				)


			var parameter_payload := (
				_build_parameter_payload(parameter)
			)


			if parameter_payload.is_empty():

				AIHubPlugin.print_err(
					"Error: Tool %s cannot be used because "
					+ "of an error in parameter %s."
					% [
						tool.get_function_name(),
						parameter.name
					]
				)

				failed = true
				break


			parameters.append(
				parameter_payload
			)


		var access: AIToolAccess = (
			tool_data.tool_access
		)


		var tool_description: String


		if access.option_values.has(
			AI_TOOL_OPTION_EXTENDED_PROMPT.id
		):

			tool_description = (
				"%s\n\n*Important instructions:*\n%s"
				% [
					tool.get_description(),
					access.option_values[
						AI_TOOL_OPTION_EXTENDED_PROMPT.id
					]
				]
			)

		else:
			tool_description = tool.get_description()


		if not failed:

			var function_data := {
				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.Name
				]:
					tool.get_function_name(),

				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.Description
				]:
					tool_description.json_escape(),

				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.Parameters
				]:
					",\n".join(parameters),

				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.RequiredParams
				]:
					required_parameters
			}


			tool_parts.append(
				_llm_provider.tool_payload_template.format(
					function_data
				)
			)


	var payload_string := (
		"[\n%s\n]"
		% ",".join(tool_parts)
	)


	var payload := JSON.new()

	var error := payload.parse(
		payload_string
	)


	if error == OK:
		return payload.get_data()


	AIHubPlugin.print_err(
		"JSON payload for tools is invalid. "
		+ "Error: %s at line %d.\nFull payload:\n%s"
		% [
			payload.get_error_message(),
			payload.get_error_line(),
			payload_string
		]
	)

	return []


# -------------------------------------------------------------------------
# Parameter payload
# -------------------------------------------------------------------------

func _build_parameter_payload(
	parameter: AIToolParameter
) -> String:

	var type := (
		_get_parameter_type_payload_name(
			parameter.type
		)
	)


	if type.is_empty():

		AIHubPlugin.print_err(
			"Error: Parameter type %s is not supported."
			% AIToolParameter.ParameterType.find_key(
				parameter.type
			)
		)

		return ""


	var param_data := {
		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Name
		]:
			parameter.name,

		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Description
		]:
			parameter.description.json_escape(),

		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Type
		]:
			type
	}


	var parameter_payload_template := (
		_llm_provider.tool_param_payload_template
	)


	var enum_key := (
		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Enum
		]
	)


	if parameter.type == AIToolParameter.ParameterType.StringEnum:

		param_data[enum_key] = (
			parameter.string_enum_valid_values
		)

	else:

		parameter_payload_template = (
			_remove_line_with_substring(
				parameter_payload_template,
				enum_key
			)
		)


	return parameter_payload_template.format(
		param_data
	)


# -------------------------------------------------------------------------
# Parameter type mapping
# -------------------------------------------------------------------------

func _get_parameter_type_payload_name(
	parameter_type: AIToolParameter.ParameterType
) -> String:

	var name: String


	match parameter_type:

		AIToolParameter.ParameterType.Int:
			name = _llm_provider.tool_param_type_int

		AIToolParameter.ParameterType.Float:
			name = _llm_provider.tool_param_type_float

		AIToolParameter.ParameterType.Boolean:
			name = _llm_provider.tool_param_type_boolean

		AIToolParameter.ParameterType.String:
			name = _llm_provider.tool_param_type_string

		AIToolParameter.ParameterType.Code:
			name = _llm_provider.tool_param_type_string

		AIToolParameter.ParameterType.StringEnum:
			name = _llm_provider.tool_param_type_string

		AIToolParameter.ParameterType.Array:
			name = _llm_provider.tool_param_type_array


	return name


# -------------------------------------------------------------------------
# Utility
# -------------------------------------------------------------------------

func _remove_line_with_substring(
	original_text: String,
	substring: String
) -> String:

	var lines := original_text.split("\n")
	var filtered_lines: Array[String] = []


	for line in lines:
		if not line.contains(substring):
			filtered_lines.append(line)


	return "\n".join(filtered_lines)
The important part is that your existing OllamaTurboAPI can inherit from this without changing its overall architecture.
One other thing: I would not remove the tool/capability system. That's useful for Skull Cap because it lets the local Ollama model eventually call your Godot tools for things like creating scenes, editing scripts, generating assets, and modifying the project.
If you give me the LLMProviderResource definition next, I can make the Ollama provider + provider resource configuration line up exactly, rather than guessing the URL postfixes or capability format.
Yes — with this LLMInterface, I can see exactly how your OllamaTurboAPI is supposed to plug in.
There is one major issue in the base class that I would fix before changing the Ollama provider: the property setters recursively assign to themselves.
For example:
var model: String:
	set(value):
		model = value
That setter calls the setter again. The same problem exists for override_temperature, temperature, reasoning, and context_length.
Use backing variables instead.
Corrected LLMInterface.gd
Writing
@tool
class_name LLMInterface
extends RefCounted

# Base interface for all LLM providers used by AI Assistant Hub.


signal model_changed(model: String)
signal override_temperature_changed(value: bool)
signal temperature_changed(temperature: float)
signal reasoning_changed(reasoning: String)
signal tools_enabled_changed(value: bool)
signal llm_config_changed
signal context_usage_updated(max: int, current: int)


enum Capabilities {
	Tools,
	ReasoningLevels
}


enum ToolPayloadParts {
	Name,
	Description,
	Parameters,
	RequiredParams
}


enum ParamPayloadParts {
	Name,
	Description,
	Type,
	Enum
}


const AI_TOOL_OPTION_EXTENDED_PROMPT = preload(
	"res://addons/ai_assistant_hub/tools/general_params_and_options/ai_tool_option_extended_prompt.tres"
)

const TOOL_DEFAULT_ACCESS_PROFILE: AIToolAccessProfile = preload(
	"res://addons/ai_assistant_hub/tools/access_profiles/default_access.tres"
)

const TOOL_CUSTOM_ACCESS_PATH := (
	"res://addons/ai_assistant_hub/tools/access_profiles/custom_access.tres"
)


const TOOL_PAYLOAD_KEYWORDS := {
	ToolPayloadParts.Name: "<:NAME:>",
	ToolPayloadParts.Description: "<:DESC:>",
	ToolPayloadParts.Parameters: "<:PARAM:>",
	ToolPayloadParts.RequiredParams: "<:REQP:>"
}


const PARAM_PAYLOAD_KEYWORDS := {
	ParamPayloadParts.Name: "<:NAME:>",
	ParamPayloadParts.Description: "<:DESC:>",
	ParamPayloadParts.Type: "<:TYPE:>",
	ParamPayloadParts.Enum: "<:ENUM:>"
}


const INVALID_RESPONSE := "[INVALID_RESPONSE]"


# -------------------------------------------------------------------------
# Public configuration properties
# -------------------------------------------------------------------------

var _model: String = ""
var _override_temperature: bool = false
var _temperature: float = 0.7
var _reasoning: String = ""
var _tools_enabled: bool = false
var _context_length: int = 0


var model: String:
	get:
		return _model
	set(value):
		if _model == value:
			return

		_model = value
		_max_context = 0
		_current_context = 0

		context_usage_updated.emit(0, 0)
		model_changed.emit(value)


var override_temperature: bool:
	get:
		return _override_temperature
	set(value):
		if _override_temperature == value:
			return

		_override_temperature = value
		override_temperature_changed.emit(value)


var temperature: float:
	get:
		return _temperature
	set(value):
		if is_equal_approx(_temperature, value):
			return

		_temperature = value
		temperature_changed.emit(value)


var reasoning: String:
	get:
		return _reasoning
	set(value):
		if _reasoning == value:
			return

		_reasoning = value
		reasoning_changed.emit(value)


var tools_enabled: bool:
	get:
		return _tools_enabled
	set(value):
		if _tools_enabled == value:
			return

		_tools_enabled = value
		tools_enabled_changed.emit(value)


var context_length: int:
	get:
		return _context_length
	set(value):
		_context_length = value


# -------------------------------------------------------------------------
# Internal provider state
# -------------------------------------------------------------------------

var _msg_cleaner := ResponseCleaner.new()

var _base_url: String = ""
var _models_url: String = ""
var _chat_url: String = ""
var _max_context_url: String = ""
var _capabilities_url: String = ""

var _api_key: String = ""

var _llm_provider: LLMProviderResource

var _max_context: int = 0
var _current_context: int = 0

var _available_tools: Dictionary = {}
var _manual_approval_tool_ids: Array[String] = []
var _tools_payload: Array = []

var _tool_undo_queue := AIToolUndoQueue.new()
var _global_tool_option_values: Dictionary = {}

var _supports_reasoning_levels: bool = false
var _supports_tools: bool = false


# -------------------------------------------------------------------------
# Tool access wrapper
# -------------------------------------------------------------------------

class ToolWithAccess:
	var tool_definition: AIToolResource
	var tool_access: AIToolAccess

	func _init(
		_tool_definition: AIToolResource,
		_tool_access: AIToolAccess
	) -> void:
		tool_definition = _tool_definition
		tool_access = _tool_access


# -------------------------------------------------------------------------
# Initialization
# -------------------------------------------------------------------------

func _init(llm_provider: LLMProviderResource) -> void:
	if llm_provider == null:
		AIHubPlugin.print_err(
			"Tried to create LLM instance with no provider."
		)
		return

	_llm_provider = llm_provider

	load_llm_parameters()
	_initialize()


func get_llm_provider() -> LLMProviderResource:
	return _llm_provider


func load_llm_parameters() -> void:
	if _llm_provider == null:
		return

	var config := LLMConfigManager.new(
		_llm_provider.api_id
	)

	if _llm_provider.fix_url.is_empty():
		var custom_url := config.load_url()

		if custom_url.is_empty():
			_base_url = _llm_provider.default_url
		else:
			_base_url = custom_url
	else:
		_base_url = _llm_provider.fix_url


	# Remove accidental trailing slash.
	_base_url = _base_url.trim_suffix("/")


	_models_url = (
		_base_url +
		_llm_provider.models_url_postfix
	)

	_chat_url = (
		_base_url +
		_llm_provider.chat_url_postfix
	)

	_max_context_url = (
		_base_url +
		_llm_provider.max_context_url_postfix
	)

	_capabilities_url = (
		_base_url +
		_llm_provider.capabilities_url_postfix
	)

	_api_key = config.load_key()

	llm_config_changed.emit()


# -------------------------------------------------------------------------
# Generic JSON response helper
# -------------------------------------------------------------------------

func get_full_response(body: PackedByteArray) -> Variant:
	var text := body.get_string_from_utf8()

	var json := JSON.new()
	var parse_result := json.parse(text)

	if parse_result != OK:
		AIHubPlugin.print_err(
			"Failed to parse JSON in get_full_response: %s"
			% json.get_error_message()
		)

		return text


	var data = json.get_data()

	if data is Dictionary:
		return data


	AIHubPlugin.print_err(
		"Parsed JSON is not a Dictionary in get_full_response."
	)

	return text


# -------------------------------------------------------------------------
# Context
# -------------------------------------------------------------------------

func check_context_usage(http_request: HTTPRequest) -> void:
	if _max_context > 0:
		context_usage_updated.emit(
			_max_context,
			_current_context
		)
	else:
		detect_max_context(http_request)


# -------------------------------------------------------------------------
# Capabilities
# -------------------------------------------------------------------------

func load_capabilities(
	model_capabilities: Array[Capabilities],
	tool_access: AIToolAccessProfile
) -> void:

	AIHubPlugin.print_msg(
		"Loading capabilities."
	)

	_supports_reasoning_levels = false
	_supports_tools = false


	if model_capabilities:
		for capability in model_capabilities:
			match capability:
				Capabilities.ReasoningLevels:
					_supports_reasoning_levels = true

				Capabilities.Tools:
					_supports_tools = true


	if not _supports_tools:
		return

	if tool_access == null:
		tool_access = TOOL_DEFAULT_ACCESS_PROFILE


	_global_tool_option_values = (
		tool_access.get_global_option_values()
	)

	_available_tools.clear()
	_manual_approval_tool_ids.clear()


	for key in tool_access.permissions:
		var tool_definition: AIToolResource = key
		var access: AIToolAccess = tool_access.permissions[key]

		if access.usage_permission != AIToolAccess.Permission.Hide:

			_available_tools[tool_definition.id] = (
				ToolWithAccess.new(
					tool_definition,
					access
				)
			)

			if (
				access.usage_permission ==
				AIToolAccess.Permission.Ask
			):
				_manual_approval_tool_ids.append(
					tool_definition.id
				)


	_tools_payload = _build_tools_payload()


# -------------------------------------------------------------------------
# Tool permissions
# -------------------------------------------------------------------------

func get_permission_for_tool(
	tool_id: String
) -> AIToolAccess.Permission:

	if _manual_approval_tool_ids.has(tool_id):
		return AIToolAccess.Permission.Ask

	if _available_tools.has(tool_id):
		return AIToolAccess.Permission.Allow

	return AIToolAccess.Permission.Hide


func get_tool_instance(tool_id: String) -> AITool:
	if not _available_tools.has(tool_id):
		AIHubPlugin.print_err(
			"Requested unavailable tool: %s"
			% tool_id
		)

		return null


	var tool_data: ToolWithAccess = (
		_available_tools.get(tool_id)
	)

	if tool_data == null:
		return null


	var option_values := {}

	var tool_opt_values := (
		tool_data.tool_access.option_values
	)


	for option in tool_data.tool_definition.options:
		var option_id := option.id

		var in_global := (
			_global_tool_option_values.has(option_id)
			and
			_global_tool_option_values[option_id] != null
		)

		var in_tool := (
			tool_opt_values.has(option_id)
			and
			tool_opt_values[option_id] != null
		)


		if (
			in_tool
			and
			in_global
			and
			(
				option.type ==
				AIToolOption.OptionType.ArrayOfProjectDir
				or
				option.type ==
				AIToolOption.OptionType.ArrayOfProjectFiles
			)
		):
			var combined_value := []

			combined_value.append_array(
				tool_opt_values[option_id]
			)

			combined_value.append_array(
				_global_tool_option_values[option_id]
			)

			option_values[option_id] = combined_value

		elif in_global:
			option_values[option_id] = (
				_global_tool_option_values[option_id]
			)

		elif in_tool:
			option_values[option_id] = (
				tool_opt_values[option_id]
			)


	var tool: AITool = (
		tool_data.tool_definition.create_instance(
			option_values,
			_tool_undo_queue
		)
	)


	if tool:
		return tool


	AIHubPlugin.print_err(
		"An error occurred when creating an instance of tool %s."
		% tool_id
	)

	return null


# -------------------------------------------------------------------------
# Provider methods
# These are intentionally overridden by provider classes.
# -------------------------------------------------------------------------

func send_get_models_request(
	http_request: HTTPRequest
) -> bool:
	return false


func read_models_response(
	body: PackedByteArray
) -> Array[String]:

	return [INVALID_RESPONSE]


func send_chat_request(
	http_request: HTTPRequest,
	content: Array
) -> bool:

	return false


func read_response(
	body: PackedByteArray
) -> AIAssistantResponse:

	return null


func detect_max_context(
	http_request: HTTPRequest
) -> void:
	return


func read_max_context_http_response(
	body: PackedByteArray
) -> void:
	return


func send_get_capabilities_request(
	http_request: HTTPRequest,
	model_name: String
) -> bool:

	return false


func read_capabilities_response(
	body: PackedByteArray
) -> Array[Capabilities]:

	return []


# -------------------------------------------------------------------------
# Provider initialization hook
# -------------------------------------------------------------------------

func _initialize() -> void:
	return


# -------------------------------------------------------------------------
# Tool payload generation
# -------------------------------------------------------------------------

func _build_tools_payload() -> Array:
	var tool_parts: Array[String] = []


	for tool_data in _available_tools.values():

		var tool: AITool = (
			tool_data.tool_definition.create_instance(
				tool_data.tool_access.option_values,
				_tool_undo_queue
			)
		)


		if tool == null:
			AIHubPlugin.print_err(
				"An error occurred when creating an instance "
				+ "of tool %s. Tool skipped from payload."
				% tool_data.tool_definition.id
			)

			continue


		var parameters_definition := (
			tool.get_parameters()
		)

		var parameters: Array[String] = []
		var required_parameters: Array[String] = []

		var failed := false


		for parameter in parameters_definition:

			if parameter.required:
				required_parameters.append(
					parameter.name
				)


			var parameter_payload := (
				_build_parameter_payload(parameter)
			)


			if parameter_payload.is_empty():

				AIHubPlugin.print_err(
					"Error: Tool %s cannot be used because "
					+ "of an error in parameter %s."
					% [
						tool.get_function_name(),
						parameter.name
					]
				)

				failed = true
				break


			parameters.append(
				parameter_payload
			)


		var access: AIToolAccess = (
			tool_data.tool_access
		)


		var tool_description: String


		if access.option_values.has(
			AI_TOOL_OPTION_EXTENDED_PROMPT.id
		):

			tool_description = (
				"%s\n\n*Important instructions:*\n%s"
				% [
					tool.get_description(),
					access.option_values[
						AI_TOOL_OPTION_EXTENDED_PROMPT.id
					]
				]
			)

		else:
			tool_description = tool.get_description()


		if not failed:

			var function_data := {
				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.Name
				]:
					tool.get_function_name(),

				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.Description
				]:
					tool_description.json_escape(),

				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.Parameters
				]:
					",\n".join(parameters),

				TOOL_PAYLOAD_KEYWORDS[
					ToolPayloadParts.RequiredParams
				]:
					required_parameters
			}


			tool_parts.append(
				_llm_provider.tool_payload_template.format(
					function_data
				)
			)


	var payload_string := (
		"[\n%s\n]"
		% ",".join(tool_parts)
	)


	var payload := JSON.new()

	var error := payload.parse(
		payload_string
	)


	if error == OK:
		return payload.get_data()


	AIHubPlugin.print_err(
		"JSON payload for tools is invalid. "
		+ "Error: %s at line %d.\nFull payload:\n%s"
		% [
			payload.get_error_message(),
			payload.get_error_line(),
			payload_string
		]
	)

	return []


# -------------------------------------------------------------------------
# Parameter payload
# -------------------------------------------------------------------------

func _build_parameter_payload(
	parameter: AIToolParameter
) -> String:

	var type := (
		_get_parameter_type_payload_name(
			parameter.type
		)
	)


	if type.is_empty():

		AIHubPlugin.print_err(
			"Error: Parameter type %s is not supported."
			% AIToolParameter.ParameterType.find_key(
				parameter.type
			)
		)

		return ""


	var param_data := {
		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Name
		]:
			parameter.name,

		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Description
		]:
			parameter.description.json_escape(),

		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Type
		]:
			type
	}


	var parameter_payload_template := (
		_llm_provider.tool_param_payload_template
	)


	var enum_key := (
		PARAM_PAYLOAD_KEYWORDS[
			ParamPayloadParts.Enum
		]
	)


	if parameter.type == AIToolParameter.ParameterType.StringEnum:

		param_data[enum_key] = (
			parameter.string_enum_valid_values
		)

	else:

		parameter_payload_template = (
			_remove_line_with_substring(
				parameter_payload_template,
				enum_key
			)
		)


	return parameter_payload_template.format(
		param_data
	)


# -------------------------------------------------------------------------
# Parameter type mapping
# -------------------------------------------------------------------------

func _get_parameter_type_payload_name(
	parameter_type: AIToolParameter.ParameterType
) -> String:

	var name: String


	match parameter_type:

		AIToolParameter.ParameterType.Int:
			name = _llm_provider.tool_param_type_int

		AIToolParameter.ParameterType.Float:
			name = _llm_provider.tool_param_type_float

		AIToolParameter.ParameterType.Boolean:
			name = _llm_provider.tool_param_type_boolean

		AIToolParameter.ParameterType.String:
			name = _llm_provider.tool_param_type_string

		AIToolParameter.ParameterType.Code:
			name = _llm_provider.tool_param_type_string

		AIToolParameter.ParameterType.StringEnum:
			name = _llm_provider.tool_param_type_string

		AIToolParameter.ParameterType.Array:
			name = _llm_provider.tool_param_type_array


	return name


# -------------------------------------------------------------------------
# Utility
# -------------------------------------------------------------------------

func _remove_line_with_substring(
	original_text: String,
	substring: String
) -> String:

	var lines := original_text.split("\n")
	var filtered_lines: Array[String] = []


	for line in lines:
		if not line.contains(substring):
			filtered_lines.append(line)


	return "\n".join(filtered_lines)
The important part is that your existing OllamaTurboAPI can inherit from this without changing its overall architecture.
One other thing: I would not remove the tool/capability system. That's useful for Skull Cap because it lets the local Ollama model eventually call your Godot tools for things like creating scenes, editing scripts, generating assets, and modifying the project.
If you give me the LLMProviderResource definition next, I can make the Ollama provider + provider resource configuration line up exactly, rather than guessing the URL postfixes or capability format.
Done. I rebuilt the project around the actual ZIP you uploaded so the main project is designed to launch directly instead of relying on the broken UI/plugin startup.
What changed
res://main.tscn is now the explicit main scene.
Removed the duplicate Main autoload.
Disabled the editor plugin from automatic startup so plugin errors can't stop the project from running.
Rebuilt the UI using Godot containers so buttons stay in place when the window changes size.
Send, Clear Chat, and Refresh Models are wired directly.
Added Ollama model detection.
Added Ollama /api/chat communication.
Added Ctrl+Enter to send.
Removed the old transparent-window setting.
Removed the long boot-splash delay.
Added a RUN_ME.txt.
Added an AI project-organizer helper.
Kept the original addons/ai_assistant_hub files in the project for later integration.
Removed the generated .godot cache so Godot can regenerate it cleanly.
Verified the resulting ZIP has no archive corruption.
🚀 Run-ready ZIP
Download AI Hub 2.0 — RUN READY
Open the extracted ai-hub-2.0-godot-project-2 folder in Godot and press Run Project.
The first screen should now come up without requiring you to manually connect buttons or configure the scene.
I inspected the actual ZIP and found the main cause of the broken UI: the AI chat scene/script had been corrupted with duplicate signal handlers and dozens of bogus button/control signal connections. There was also a bad run/main_scene UID and a duplicate autoload.
I repaired those and reorganized the project.
Repaired
Fixed the corrupted ai_chat.gd.
Restored the intended button signal connections.
Removed the bogus autogenerated signal handlers.
Removed the extra overlaid A_iHub2_0 sprite that could interfere with the UI.
Removed stray ChatHistoryEntry/tool UI instances from the chat scene.
Fixed the project to launch res://main.tscn.
Removed the duplicate Main autoload.
Changed the transparent game window to a normal window.
Rebuilt the main page using Godot Container layouts so controls resize correctly.
Added working Chat, Connection, Plugin Info, Refresh Models, Send, and Clear Chat buttons.
Added direct Ollama model discovery and chat support.
Organized the unrelated embedded repositories under vendor/.
Cleaned the root Modelfile.
Added a repair report.
The ZIP also passed an archive integrity test.
Download
Download the repaired & organized AI Hub 2.0 ZIP
The original AI Assistant Hub editor plugin is still included; I did not remove its AI tools or provider code. The project is now separated more cleanly between the actual AI Hub project and the embedded external repositories. The upstream plugin itself is designed for Godot 4.7 and supports Ollama and several other providers. �
github.com +1
Yes — that sounds like the UI scene/layout and signal wiring need to be repaired, not just the project folders.
For the Godot AI-chat project, I can fix it so:
Buttons are positioned correctly and resize properly.
Buttons actually have their pressed signals connected.
Chat input and Send button work.
AI response area works.
Sidebar/navigation buttons work.
Panels don't overlap or disappear at different resolutions.
Containers use proper Godot layout rules instead of hard-coded positions.
Missing nodes/references are repaired.
GDScript errors are fixed.
The ai-chat-main.svg asset is correctly referenced.
The finished project is packaged as a new ZIP.
I need the actual project
The ZIP isn't currently attached to this conversation, so I can't safely repair the real scene/scripts yet.
Upload the current Godot project .zip, including:
project.godot
*.tscn
*.gd
*.svg
*.png
addons/
If it's large, upload the ZIP as-is rather than trying to extract it.
Once you attach it, I'll work from the actual files and return a repaired, organized Godot project ZIP, rather than giving you generic replacement code.
Absolutely. I can build it against the actual contents, but the Godot project ZIP isn't attached to this conversation yet.
Upload the .zip here. Once it’s available, I’ll:
Inspect the complete project tree.
Identify the actual Godot version/project structure.
Classify scripts, scenes, assets, shaders, resources, plugins, AI files, etc.
Preserve Godot-critical files and res:// dependencies.
Detect duplicates/orphaned files where possible.
Build the AI Project Organizer specifically for this project.
Reorganize the project.
Add a reusable organizer inside the project so you can run it again later.
Test the resulting structure for broken references.
Produce one organized ZIP ready to use.
I won't invent a generic structure—the organizer will be based on what's actually inside your ZIP.
Send the Godot project ZIP and I'll start from the real files.
Yes. If you mean an AI-powered file that you put into the Godot project ZIP, which scans the entire project and automatically reorganises it into sensible folders, I can build that.
A good structure for your Godot AI project would be:
SkullCap/
├── project.godot
├── addons/
│   └── ai_project_organizer/
│       ├── plugin.cfg
│       ├── ai_project_organizer.gd
│       └── organizer_rules.json
├── scenes/
├── scripts/
│   ├── ai/
│   ├── core/
│   ├── ui/
│   └── systems/
├── assets/
│   ├── textures/
│   ├── models/
│   ├── audio/
│   ├── fonts/
│   └── icons/
├── shaders/
├── resources/
├── data/
├── docs/
├── tests/
└── .godot/
The organizer can:
🔍 Scan the whole project recursively.
🤖 Identify files by extension and filename/content.
📁 Create appropriate folders automatically.
🔄 Move scripts, scenes, textures, models, shaders, audio, etc.
🔗 Update res:// references when files are moved.
🧹 Detect duplicate files.
⚠️ Protect project.godot, .godot/, imported files and other critical files.
📋 Generate an organization report.
↩️ Create a manifest so changes can be reversed.
🧠 Optionally use a local AI such as Ollama to classify ambiguous files.
📦 �⁠Work on the extracted project and produce an organized ZIP.
One important choice: I recommend making it dry-run first so it produces a proposed organization without risking your project, then applying the changes after approval.
If you upload the Godot project ZIP, I can �⁠build the organizer around its actual contents and produce an organized ZIP rather than guessing the project's current structure.
Yes. If you mean an AI-powered file that you put into the Godot project ZIP, which scans the entire project and automatically reorganises it into sensible folders, I can build that.
A good structure for your Godot AI project would be:
SkullCap/
├── project.godot
├── addons/
│   └── ai_project_organizer/
│       ├── plugin.cfg
│       ├── ai_project_organizer.gd
│       └── organizer_rules.json
├── scenes/
├── scripts/
│   ├── ai/
│   ├── core/
│   ├── ui/
│   └── systems/
├── assets/
│   ├── textures/
│   ├── models/
│   ├── audio/
│   ├── fonts/
│   └── icons/
├── shaders/
├── resources/
├── data/
├── docs/
├── tests/
└── .godot/
The organizer can:
🔍 Scan the whole project recursively.
🤖 Identify files by extension and filename/content.
📁 Create appropriate folders automatically.
🔄 Move scripts, scenes, textures, models, shaders, audio, etc.
🔗 Update res:// references when files are moved.
🧹 Detect duplicate files.
⚠️ Protect project.godot, .godot/, imported files and other critical files.
📋 Generate an organization report.
↩️ Create a manifest so changes can be reversed.
🧠 Optionally use a local AI such as Ollama to classify ambiguous files.
📦 �⁠Work on the extracted project and produce an organized ZIP.
One important choice: I recommend making it dry-run first so it produces a proposed organization without risking your project, then applying the changes after approval.
If you upload the Godot project ZIP, I can �⁠build the organizer around its actual contents and produce an organized ZIP rather than guessing the project's current structure.
That is a Godot .import file for ai-chat-main.svg. It looks structurally normal for an imported SVG texture.
What it does
Source: res://ai-chat-main.svg
Imported type: CompressedTexture2D
Generated cache: .godot/imported/...ctex
SVG scale: 1.0
VRAM texture: disabled
Mipmaps: disabled
Lossy compression: effectively unused because compress/mode=0
3D compression: enabled as the default setting, though this is a 2D SVG texture.
Important
You generally shouldn't manually edit this file. Godot generates it automatically when it imports the SVG.
Your project should contain:
your_project/
├── ai-chat-main.svg
├── ai-chat-main.svg.import
└── .godot/
    └── imported/
        └── ai-chat-main.svg-...ctex
If you're trying to fix the AI chat UI/plugin you were working on, the important file is actually:
res://ai-chat-main.svg
The .import file only tells Godot how to process that SVG.
If you're getting an error involving this asset, send me the Godot error message and I can fix the relevant project files rather than modifying the generated .import file.
Yes — those errors show the project is loading several incompatible plugins/autoloads that should not be enabled on Android.
The biggest problems are:
reactive_ui_analyzer/gdscript_analyzer.gdextension has no Android x86_64 library.
Multiple broken autoloads are being loaded.
The Ollama commands were accidentally concatenated into the class name/error.
.tres resources were incorrectly registered as autoloads.
The Godot Android cache is also reporting write-permission failures.
The original AI Hub editor plugin is designed primarily for the Godot editor, not as an Android runtime plugin.
I made you an Android-safe repaired build that preserves the AI Hub source but prevents the incompatible components from loading.
Download the fixed project
Download AI Hub 2.0 — Android Fixed Build
What this version does
AI_Hub_2.0_Android_Fixed/
├── project.godot          ← clean Godot 4.3 project
├── main.tscn              ← runnable scene
├── main.gd                ← Android-safe AI Hub UI
├── Modelfile              ← corrected Ollama file
├── README.md
└── disabled_addons/
    └── ai_assistant_hub/  ← original AI Hub preserved
Important: Don't copy the old project.godot autoload/plugin entries back into this version. That would reintroduce the errors.
The new project should launch without the reactive_ui_analyzer, Copilot, UniverseManager, procedural-galaxy, or broken AI-Hub autoload errors.
You currently have two extends RigidBody3D scripts pasted together. That will cause a parse error. Keep only one version.
Here is the single combined, cleaned Godot 4 script:
extends RigidBody3D
class_name ShipController

# ============================================================
# SHIP FLIGHT SETTINGS
# ============================================================

@export_category("Flight")
@export var forward_thrust: float = 120.0
@export var rotation_torque: float = 4.0

@export_category("Damping")
@export var linear_damping: float = 0.8
@export var angular_damping: float = 2.5


# ============================================================
# INITIALIZATION
# ============================================================

func _ready() -> void:
	linear_damp = linear_damping
	angular_damp = angular_damping


# ============================================================
# PHYSICS PROCESS
# ============================================================

func _physics_process(_delta: float) -> void:

	# --------------------------------------------------------
	# MOVEMENT INPUT
	# --------------------------------------------------------

	var movement_input := Vector3.ZERO

	# Forward / backward
	if Input.is_key_pressed(KEY_W):
		movement_input.z -= 1.0

	if Input.is_key_pressed(KEY_S):
		movement_input.z += 1.0

	# Left / right strafe
	if Input.is_key_pressed(KEY_A):
		movement_input.x -= 1.0

	if Input.is_key_pressed(KEY_D):
		movement_input.x += 1.0

	# Up / down
	if Input.is_key_pressed(KEY_SPACE):
		movement_input.y += 1.0

	if Input.is_key_pressed(KEY_CTRL):
		movement_input.y -= 1.0

	_apply_movement(movement_input)


	# --------------------------------------------------------
	# ROTATION INPUT
	# --------------------------------------------------------

	var rotation_input := Vector3.ZERO

	# Pitch
	if Input.is_key_pressed(KEY_UP):
		rotation_input.x -= 1.0

	if Input.is_key_pressed(KEY_DOWN):
		rotation_input.x += 1.0

	# Yaw
	if Input.is_key_pressed(KEY_LEFT):
		rotation_input.y += 1.0

	if Input.is_key_pressed(KEY_RIGHT):
		rotation_input.y -= 1.0

	# Roll
	if Input.is_key_pressed(KEY_Q):
		rotation_input.z -= 1.0

	if Input.is_key_pressed(KEY_E):
		rotation_input.z += 1.0

	_apply_rotation(rotation_input)


# ============================================================
# MOVEMENT
# ============================================================

func _apply_movement(input_vector: Vector3) -> void:

	if input_vector == Vector3.ZERO:
		return

	var direction := input_vector.normalized()

	# Convert local-space direction into world-space direction.
	var world_direction := global_transform.basis * direction

	apply_central_force(
		world_direction * forward_thrust
	)


# ============================================================
# ROTATION
# ============================================================

func _apply_rotation(input_vector: Vector3) -> void:

	if input_vector == Vector3.ZERO:
		return

	var direction := input_vector.normalized()

	# Convert local-space torque into world-space torque.
	var world_torque := global_transform.basis * direction

	apply_torque(
		world_torque * rotation_torque
	)
Important
Delete this entire first copy from your file:
extends RigidBody3D

@export var forward_thrust: float = 120.0
...
and use only the combined script above.
Your scene should then look roughly like:
Ship (RigidBody3D)
├── CollisionShape3D
├── MeshInstance3D
├── Camera3D
├── EngineParticles
└── Lights
Attach ShipController.gd directly to the Ship (RigidBody3D).
The controls are:
Key
Function
W
Forward
S
Backward
A
Strafe left
D
Strafe right
Space
Up
Ctrl
Down
↑
Pitch up
↓
Pitch down
←
Yaw left
→
Yaw right
Q
Roll left
E
Roll right
One further improvement I'd recommend is changing this from a simple constant-force controller into a proper 6-DOF spacecraft flight system with throttle, braking, maximum velocity, independent pitch/yaw/roll rates, inertial dampening, boost, and an optional atmospheric flight mode.
https://chatgpt.com/share/6a9ea333-8718-83ec-be7b-4741efb2cf7e?ogimg=plain
https://chatgpt.com/share/6a9ee36c-d9b4-83ec-88f7-8650c133b13c?ogimg=plain
