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
