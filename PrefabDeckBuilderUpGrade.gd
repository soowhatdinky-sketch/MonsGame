func _get_unified_scene_source() -> String:
	return '''[gd_scene load_steps=6 format=3]
[ext_resource type="Script" path="res://scripts/MassiveShip.gd" id="1"]
[ext_resource type="Script" path="res://scripts/ShipInterior.gd" id="2"]
[ext_resource type="Script" path="res://scripts/ShipSystems.gd" id="3"]
[ext_resource type="Script" path="res://scripts/FirstPersonPlayer.gd" id="4"]

[sub_resource type="Environment" id="Environment_deep_space"]
background_mode = 1
background_color = Color(0.003, 0.005, 0.015, 1)
ambient_light_source = 3
ambient_light_color = Color(0.12, 0.16, 0.26, 1)
ambient_light_energy = 0.65
tonemap_mode = 2
glow_enabled = true
glow_intensity = 1.3

[sub_resource type="CapsuleShape3D" id="CapsuleShape3D_player"]
radius = 1.2
height = 5.0

[node name="VesselCommandPlatform" type="Node3D"]

[node name="DeepSpaceEnvironment" type="WorldEnvironment" parent="."]
environment = SubResource("Environment_deep_space")

[node name="PrimarySolarLight" type="DirectionalLight3D" parent="."]
transform = Transform3D(0.906308, -0.242404, 0.346188, 0, 0.819152, 0.573576, -0.422618, -0.519837, 0.742404, 0, 0, 0)
light_energy = 1.5
shadow_enabled = true

[node name="CapitalShipHull" type="Node3D" parent="."]
script = ExtResource("1")

[node name="InteriorMatrix" type="Node3D" parent="."]
script = ExtResource("2")

[node name="ShipSystems" type="Node3D" parent="."]
script = ExtResource("3")

[node name="FirstPersonCharacter" type="CharacterBody3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, -172, -100)
script = ExtResource("4")

[node name="PlayerColliderShape" type="CollisionShape3D" parent="FirstPersonCharacter"]
shape = SubResource("CapsuleShape3D_player")

[node name="Head" type="Node3D" parent="FirstPersonCharacter"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.8, 0)

[node name="FPSCamera" type="Camera3D" parent="FirstPersonCharacter/Head"]
current = true
fov = 75.0
near = 0.05
far = 10000.0
'''
