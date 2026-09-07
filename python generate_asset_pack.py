#!/usr/bin/env python3
import os
import zipfile

# Absolute environmental mappings matching your Android sandbox framework
SANDBOX_PATH = "/storage/emulated/0/Documents/scifi-starter-kit---godot-3/"
TARGET_RELEASE_ZIP = "/storage/emulated/0/Documents/skull_cap_capital_ship.zip"

print(f"[*] Commencing automated structural configuration pass inside workspace root: {SANDBOX_PATH}")

# Explicit database dictionary of every framework asset established across pages
system_files_matrix = {
    # ----------------------------------------------------
    # ENGINE METADATA FILE
    # ----------------------------------------------------
    "project.godot": """config_version=5

[animation]
compatibility/default_parent_skeleton_in_mesh_instance_3d=true

[application]
config/name="Skull Cap — Capital Ship"
run/main_scene="res://Creepy_Cat/scenes/CapitalShip.tscn"
config/features=PackedStringArray("4.7", "Forward Plus")
run/low_processor_mode=true
run/load_shell_environment=true
boot_splash/show_image=false

[autoload]
GdPAIAutoload="*res://addons/GdPlanningAI/ai_completions_engine.gd"
DeeplinkManager="*res://addons/DeeplinkPlugin/deeplink_manager.gd"

[editor_plugins]
enabled=PackedStringArray("res://addons/DeeplinkPlugin/plugin.cfg", "res://addons/GDQuest_GDScript_formatter/plugin.cfg", "res://addons/GdPlanningAI/plugin.cfg", "res://addons/boot_splash_plus/plugin.cfg")

[importer_defaults]
texture={"detect_3d/compress_to": 0}
animation_library={&"nodes/root_scale": 1000.0}

[input_devices]
joypads/ignore_joypad_on_unfocused_application=true

[rendering]
textures/canvas_textures/default_texture_filter=2
textures/canvas_textures/default_texture_repeat=1
textures/vram_compression/import_s3tc_bptc=true
lights_and_shadows/use_physical_light_units=true
textures/default_filters/anisotropic_filtering_level=4
viewport/transparent_background=true
""",

    # ----------------------------------------------------
    # CENTRAL SCENE INSTANTIATION NODE GRAPH
    # ----------------------------------------------------
    "Creepy_Cat/scenes/CapitalShip.tscn": """[gd_scene load_steps=6 format=3 uid="uid://bkbv8t2yunnew"]

[ext_resource type="Script" path="res://Creepy_Cat/scripts/CapitalShipController.gd" id="1"]
[ext_resource type="Script" path="res://Creepy_Cat/scripts/CapitalShipInteriorBuilder.gd" id="2"]
[ext_resource type="PackedScene" uid="uid://d1fpsplayer001" path="res://Creepy_Cat/scenes/PlayerController.tscn" id="3"]

[sub_resource type="Environment" id="Environment_deep_space"]
background_mode = 1
background_color = Color(0.003, 0.005, 0.015, 1)
ambient_light_source = 3
ambient_light_color = Color(0.12, 0.16, 0.26, 1)
ambient_light_energy = 0.65
tonemap_mode = 2
glow_enabled = true
glow_intensity = 1.3

[sub_resource type="LabelSettings" id="LabelSettings_ui"]
font_size = 20
font_color = Color(0.0, 0.75, 1.0, 1.0)
outline_size = 4
outline_color = Color(0.0, 0.05, 0.15, 0.9)

[node name="VesselCommandPlatform" type="Node3D"]
script = ExtResource("1")

[node name="DeepSpaceEnvironment" type="WorldEnvironment" parent="."]
environment = SubResource("Environment_deep_space")

[node name="PrimarySolarLight" type="DirectionalLight3D" parent="."]
transform = Transform3D(0.906308, -0.242404, 0.346188, 0, 0.819152, 0.573576, -0.422618, -0.519837, 0.742404, 0, 0, 0)
light_energy = 1.5
shadow_enabled = true

[node name="InteriorMatrix" type="Node3D" parent="."]
script = ExtResource("2")
kit_path = "res://Sci-Fi_Starter_Kit"
prefab_limit = 300

[node name="FirstPersonCharacter" parent="." instance=ExtResource("3")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 5.0, 0)

[node name="HUD" type="CanvasLayer" parent="."]

[node name="VBox" type="VBoxContainer" parent="HUD"]
offset_left = 30.0
offset_top = 30.0
offset_right = 500.0
offset_bottom = 300.0

[node name="Title" type="Label" parent="HUD/VBox"]
layout_mode = 2
text = "COMMAND CONSOLE OS V4.7"
label_settings = SubResource("LabelSettings_ui")

[node name="Telemetry" type="Label" parent="HUD/VBox"]
unique_name_in_owner = true
layout_mode = 2
text = "Awaiting Coprocessor Stream..."
label_settings = SubResource("LabelSettings_ui")
""",

    # ----------------------------------------------------
    # HARDWARE RUNTIME SYSTEMS READOUT CONTROLLER
    # ----------------------------------------------------
    "Creepy_Cat/scripts/ShipSystems.gd": """extends Node
class_name ShipSystems

var reactor_power: float = 1.0
var life_support: float = 1.0
var shields: float = 1.0
var engines: float = 1.0

func _ready() -> void:
	add_to_group("ship_systems_registry")
	print("[ShipSystems] Control matrix online.")

func set_system_power(system_name: String, value: float) -> void:
	var clamped_val = clamp(value, 0.0, 1.0)
	match system_name:
		"reactor": reactor_power = clamped_val
		"life_support": life_support = clamped_val
		"shields": shields = clamped_val
		"engines": engines = clamped_val
	print("[ShipSystems] Set system ", system_name, " to power: ", clamped_val)
""",

    "Creepy_Cat/scripts/CapitalShipController.gd": """extends Node3D
class_name CapitalShipController

@export var hull_scale := 3.6
@export var build_interior := true
@export var interior_modules := 300
@export var cruise_speed := 45.0
@export var turn_speed := 0.18

var ship_velocity := 0.0
var throttle := 0.0

const HULL := preload("res://Creepy_Cat/Sci-Fi_Starter_Kit/spherocal/tinker (2).obj")

func _ready() -> void:
	add_to_group("massive_ship")
	_build_capital_ship()
	_update_hud_interface()
	print("CAPITAL SHIP ONLINE — Hull Scale: ", hull_scale)

func _physics_process(delta: float) -> void:
	var thrust := Input.get_axis("ui_down", "ui_up")
	var yaw := Input.get_axis("ui_left", "ui_right")
	throttle = clamp(throttle + thrust * delta * 0.25, 0.0, 1.0)
	ship_velocity = lerp(ship_velocity, throttle * cruise_speed, delta * 0.8)
	rotation.y += yaw * turn_speed * delta
	_update_hud_interface()

func set_engine_power(power: float) -> void:
	throttle = clamp(power, 0.0, 1.0)
	var systems_node = get_node_or_null("/root/ShipSystems")
	if systems_node:
		systems_node.set_system_power("engines", power)

func _build_capital_ship() -> void:
	var hull := MeshInstance3D.new()
	hull.name = "Main_Hull_Mesh"
	hull.mesh = HULL
	hull.scale = Vector3.ONE * hull_scale
	hull.rotation_degrees.x = 90.0
	hull.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	add_child(hull)

	_box("Armored_Keel", Vector3(420,70,1850), Vector3(0,-250,0))
	_box("Dorsal_Spine", Vector3(280,120,1750), Vector3(0,210,40))
	
	for side in [-1.0, 1.0]:
		_box("Side_Armor_%s" % side, Vector3(260,110,1550), Vector3(side*520,10,0))
		_box("Broadside_Belt_%s" % side, Vector3(180,85,1200), Vector3(side*700,-30,80))
		_box("Engine_Barrier_%s" % side, Vector3(160,170,520), Vector3(side*610,70,690))

	_box("Command_Tower", Vector3(260,190,360), Vector3(0,360,-80))
	_box("Bridge_Forward", Vector3(210,95,240), Vector3(0,455,-235))
	_box("Bridge_Armor", Vector3(330,55,300), Vector3(0,500,-90))

	for side in [-1.0, 1.0]:
		_box("Hangar_Bay_%s" % side, Vector3(250,180,520), Vector3(side*470,-20,-620))
		_box("Hangar_Door_%s" % side, Vector3(45,145,430), Vector3(side*605,-20,-620))

	for side in [-1.0, 1.0]:
		for row in range(4):
			var x := side * (250.0 + row * 120.0)
			_cylinder("Main_Drive_%s_%d" % [side,row], 82.0-row*8.0, 500.0, Vector3(x,-80,960), Vector3(90,0,0))
			_cylinder("Drive_Nozzle_%s_%d" % [side,row], 92.0-row*8.0, 100.0, Vector3(x,-80,1240), Vector3(90,0,0))

	for i in range(7):
		_weapon_battery("Spinal_Battery_%d" % i, Vector3(0,315,-720.0+i*240.0), 0.0)

	for side in [-1.0, 1.0]:
		for i in range(6):
			_weapon_battery("Broadside_%s_%d" % [side,i], Vector3(side*690,80,-600.0+i*240.0), side*90.0)
		for z in [-420.0, -120.0, 180.0, 480.0]:
			_pd_mount(Vector3(side*540,300,z))

	_cylinder("Sensor_Mast", 24, 260, Vector3(0,560,0), Vector3.ZERO)
	_box("Sensor_Array", Vector3(420,35,120), Vector3(0,710,0))

func _box(n:String, size:Vector3, pos:Vector3, rot_y:float=0.0) -> MeshInstance3D:
	var m := MeshInstance3D.new()
	m.name = n
	var b := BoxMesh.new()
	b.size = size
	m.mesh = b
	m.position = pos
	m.rotation_degrees.y = rot_y
	add_child(m)
	m.create_trimesh_collision()
	return m

func _cylinder(n:String, radius:float, height:float, pos:Vector3, rot:Vector3) -> MeshInstance3D:
	var m := MeshInstance3D.new()
	m.name = n
	var c := CylinderMesh.new()
	c.top_radius = radius
	c.bottom_radius = radius
	c.height = height
	m.mesh = c
	m.position = pos
	m.rotation_degrees = rot
	add_child(m)
	m.create_trimesh_collision()
	return m

func _weapon_battery(n:String, pos:Vector3, yaw:float) -> void:
	_cylinder(n+"_Mount", 45, 35, pos, Vector3(0,0,0)).rotation_degrees.y = yaw
	_box(n+"_Barrel", Vector3(28,28,210), pos+Vector3(0,20,-105), yaw)

func _pd_mount(pos:Vector3) -> void:
	_cylinder("PointDefense", 22, 55, pos, Vector3.ZERO)

func _update_hud_interface() -> void:
	var label: Label = get_node_or_null("%Telemetry")
	if label:
		label.text = "Envelope: 1591m x 2371m\\nVelocity: %.2f m/s\\nThrottle: %d%%\\nEngines Active: true" % [ship_velocity, throttle * 100.0]
""",

    "Creepy_Cat/scripts/CapitalShipInteriorBuilder.gd": """extends Node3D
class_name CapitalShipInteriorBuilder

@export var kit_path := "res://Sci-Fi_Starter_Kit"
@export var prefab_limit := 300

func _ready() -> void:
	call_deferred("populate_interior_matrix")

func populate_interior_matrix() -> void:
	var files := _find_scenes_recursively(kit_path)
	var matching_prefabs: Array[String] = []
	for file in files:
		var low_name = file.to_lower()
		if "wall" in low_name or "floor" in low_name or "door" in low_name or "beam" in low_name or "pipe" in low_name:
			matching_prefabs.append(file)
			
	var loop_count = mini(prefab_limit, matching_prefabs.size())
	for idx in range(loop_count):
		var res = load(matching_prefabs[idx])
		if res is PackedScene:
			var node = res.instantiate()
			node.position = _calculate_grid_position(idx)
			add_child(node)
