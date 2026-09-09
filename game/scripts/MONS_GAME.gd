extends Control

func _ready():
	$MenuContainer/StartButton.pressed.connect(_on_start_pressed)
	$MenuContainer/SettingsButton.pressed.connect(_on_settings_pressed)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_settings_pressed():
	print("Settings pressed")
