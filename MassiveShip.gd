extends Node3D
## Master controller. The original Spherocal hull is enlarged to a capital-ship scale.
## Starter-kit prefabs are discovered at runtime if copied into res://Sci-Fi_Starter_Kit.

@export var cruise_speed := 45.0
@export var auto_spin := 0.0
var _time := 0.0

func _ready() -> void:
	add_to_group("massive_ship")
	print("SPHEROCAL MASSIVE SHIP ONLINE")
	print("Approx hull: 1591m x 2371m x 426m")
	print("Decks: 12 | Interior builder: online")

func _process(delta: float) -> void:
	_time += delta
	if auto_spin != 0.0:
		rotation.y += auto_spin * delta

func set_engine_power(power: float) -> void:
	ShipSystems.set_system("engines", power)

func get_ship_status() -> Dictionary:
	return ShipSystems.ship_status()


func _on_prefab_deck_builder_child_exiting_tree(node: Node, source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_child_order_changed(source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_editor_description_changed(node: Node, source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_editor_state_changed(source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_ready(source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_renamed(source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_replacing_by(node: Node, source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_tree_entered(source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_tree_exited(source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_tree_exiting(source: Node) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_property_list_changed(source: Object) -> void:
	pass # Replace with function body.


func _on_prefab_deck_builder_script_changed(source: Object) -> void:
	pass # Replace with function body.
