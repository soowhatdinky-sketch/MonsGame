extends Node3D
## Generates a huge, lightweight interior framework: decks, corridors, bays and reactor spaces.

@export var decks := 12
@export var deck_spacing := 30.0
@export var ship_length := 1900.0
@export var ship_width := 1250.0
@export var corridor_spacing := 100.0

func _ready() -> void:
	_build_interior()

func _build_interior() -> void:
	var mat := StandardMaterial3D.new()
	mat.metallic = 0.75
	mat.roughness = 0.38
	mat.albedo_color = Color(0.055,0.07,0.095)

	for d in range(decks):
		var y := (float(d) - float(decks - 1) / 2.0) * deck_spacing
		_box("Deck_%02d" % d, Vector3(ship_length, 2.0, ship_width), Vector3(0,y,0), mat)
		# Longitudinal spine
		_box("Spine_%02d" % d, Vector3(ship_length, 10.0, 18.0), Vector3(0,y+6,0), mat)
		# Cross corridors
		for x in range(-8,9):
			_box("Corridor_X_%02d_%02d" % [d,x], Vector3(12.0, 8.0, ship_width), Vector3(x*100.0,y+7,0), mat)
	_make_major_bays(mat)

func _make_major_bays(mat: Material3D) -> void:
	var bays = {
		"ForwardHangar": Vector3(650, 35, 520),
		"CentralEngineering": Vector3(260, 35, 420),
		"AftHangar": Vector3(-650, 35, 520),
		"ReactorCore": Vector3(-120, 35, 180),
		"Command": Vector3(780, 65, 220)
	}
	@warning_ignore('shadowed_variable_base_class')
	for name in bays:
		var p: Vector3 = bays[name]
		_box(name, Vector3(abs(p.x) * 0.35 + 120, 12, p.z), Vector3(p.x,p.y,p.z*0.15), mat)

func _box(n: String, size: Vector3, pos: Vector3, mat: Material3D) -> void:
	var mi := MeshInstance3D.new()
	mi.name = n
	var mesh := BoxMesh.new()
	mesh.size = size
	mi.mesh = mesh
	mi.position = pos
	mi.material_override = mat
	add_child(mi)


@warning_ignore('unused_parameter')
func _on_prefab_deck_builder_visibility_changed(source: Node3D, extra_arg_0: bool, extra_arg_1: bool, extra_arg_2: bool, extra_arg_3: bool, extra_arg_4: bool) -> void:
	pass # Replace with function body.


@warning_ignore('unused_parameter')
func _on_prefab_deck_builder_child_entered_tree(node: Node, source: Node) -> void:
	pass # Replace with function body.
