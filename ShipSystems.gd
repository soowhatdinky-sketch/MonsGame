extends Node
## Global ship systems registry for SPHEROCAL.

var ship_scale := Vector3(3.6, 3.6, 3.6)
var dimensions_m := Vector3(1591.0, 2371.0, 426.0)
var deck_count := 12
var prefab_root := "res://Sci-Fi_Starter_Kit"

var systems := {
	"reactor": 1.0,
	"engines": 1.0,
	"life_support": 1.0,
	"shields": 1.0,
	"gravity": 1.0
}

func set_system(name: String, value: float) -> void:
	systems[name] = clampf(value, 0.0, 1.0)

func ship_status() -> Dictionary:
	return {"dimensions_m": dimensions_m, "decks": deck_count, "systems": systems.duplicate()}
