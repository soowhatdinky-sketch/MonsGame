extends Node3D

@export var star_count: int = 4000
@export var radius: float = 800.0

func _ready():
	var mmi := MultiMeshInstance3D.new()
	var mm := MultiMesh.new()
	mm.transform_format = MultiMesh.TRANSFORM_3D
	mm.instance_count = star_count

	var star_mesh := SphereMesh.new()
	star_mesh.radius = 0.08
	star_mesh.height = 0.16
	mmi.mesh = star_mesh
	mmi.multimesh = mm
	add_child(mmi)

	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.9, 0.95, 1.0)
	mat.emission_enabled = true
	mat.emission = Color(0.9, 0.95, 1.0)
	mat.emission_energy_multiplier = 1.5
	mmi.material_override = mat

	for i in star_count:
		var p := Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized() * randf_range(radius * 0.3, radius)
		var sc := randf_range(0.5, 3.0)
		var xform := Transform3D(Basis().scaled(Vector3.ONE * sc), p)
		mm.set_instance_transform(i, xform)
