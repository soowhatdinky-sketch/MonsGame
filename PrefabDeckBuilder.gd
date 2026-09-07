extends Node3D
## Automatically imports scenes from Sci-Fi_Starter_Kit into large deck zones.
## Put any .tscn prefabs below res://Sci-Fi_Starter_Kit/ and they will be instanced.

@export var kit_path := "res://Sci-Fi_Starter_Kit"
@export var prefab_limit := 300

func _ready() -> void:
	var scenes := _find_scenes(kit_path)
	print("Starter Kit prefabs found: ", scenes.size())
	_place_prefabs(scenes)

func _find_scenes(path: String) -> Array[String]:
	var result: Array[String] = []
	var dir := DirAccess.open(path)
	if dir == null:
		return result
	dir.list_dir_begin()
	var item := dir.get_next()
	while item != "":
		if item == "." or item == "..":
			item = dir.get_next()
			continue
		var full := path.path_join(item)
		if dir.current_is_dir():
			result.append_array(_find_scenes(full))
		elif item.to_lower().ends_with(".tscn"):
			result.append(full)
		item = dir.get_next()
	dir.list_dir_end()
	return result

func _place_prefabs(paths: Array[String]) -> void:
	var count := mini(paths.size(), prefab_limit)
	for i in range(count):
		var scene := load(paths[i])
		if scene is PackedScene:
			var instance := scene.instantiate()
			instance.position = _grid_position(i)
			add_child(instance)

func _grid_position(i: int) -> Vector3:
	var cols := 12
	var row := i / cols
	var col := i % cols
	return Vector3((col - 5.5) * 110.0, ((row % 12) - 5.5) * 30.0, (row / 12 - 3) * 170.0)
