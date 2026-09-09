extends Node3D

func _ready():
	# Instantiate a player ship scene
	var player_scene = load("res://scenes/PlayerShip.tscn")
	var player = player_scene.instantiate()
	add_child(player)
	player.name = "Player"
	player.global_transform.origin = Vector3(0, 0, 0)

	# Add a starfield background
	var starfield = preload("res://scripts/Starfield.gd").new()
	add_child(starfield)

	# Create a simple chase camera and attach to the player
	var cam = Camera3D.new()
	cam.name = "ChaseCamera"
	cam.current = true
	# position camera behind the ship, looking forward at it
	cam.transform = Transform3D(Basis(), Vector3(0.0, 3.0, 12.0))
	player.add_child(cam)
