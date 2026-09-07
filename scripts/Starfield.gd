extends Node3D

@export var star_count: int = 2000
@export var radius: float = 400.0

func _ready():
	# Create a MultiMeshInstance3D for efficient star rendering
	var mmi := MultiMeshInstance3D.new()
	var mm := MultiMesh.new()
	mm.transform_format = MultiMesh.TRANSFORM_3D
	mm.color_format = MultiMesh.COLOR_8BIT
	mm.custom_data_format = MultiMesh.CUSTOM_DATA_NONE
	mm.instance_count = star_count
	
	# use a tiny sphere as the star mesh
	var star_mesh := SphereMesh.new()
	star_mesh.radius = 0.06
	mmi.multimesh = mm
	mmi.mesh = star_mesh
	add_child(mmi)

	randomize()
	for i in star_count:
		var p := Vector3(randf_range(-1,1), randf_range(-1,1), randf_range(-1,1)).normalized() * randf_range(radius * 0.2, radius)
		var xform := Transform3D(Basis(), p)
		mm.set_instance_transform(i, xform)
		# color variation
		var c := Color(1,1,1)
		mm.set_instance_color(i, c)

# small helpers
func randf_range(a: float, b: float) -> float:
	return lerp(a, b, randf())
