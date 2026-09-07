extends Node3D

@export var thrust := 30.0
@export var rotation_speed := 1.8

var velocity := Vector3.ZERO

func _ready():
	# Build a simple visual for the ship
	var mesh_inst := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 1.2
	mesh_inst.mesh = sphere
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.15, 0.6, 1.0)
	mat.metallic = 0.2
	mat.roughness = 0.4
	mesh_inst.material_override = mat
	add_child(mesh_inst)

	# subtle omni light to show the ship
	var ol := OmniLight3D.new()
	ol.light_energy = 0.8
	ol.transform.origin = Vector3(0,2,0)
	add_child(ol)

func _physics_process(delta: float) -> void:
	# Basic flight controls (forward/back + yaw)
	var thrust_input := 0.0
	if Input.is_action_pressed("ui_up"):
		thrust_input += 1.0
	if Input.is_action_pressed("ui_down"):
		thrust_input -= 1.0

	if Input.is_action_pressed("ui_left"):
		rotation.y += rotation_speed * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= rotation_speed * delta

	# Apply forward thrust along the ship's -Z axis
	var forward := -transform.basis.z
	velocity += forward * thrust_input * thrust * delta

	# simple drag
	velocity = velocity.linear_interpolate(Vector3.ZERO, 0.6 * delta)

	translate(velocity * delta)
