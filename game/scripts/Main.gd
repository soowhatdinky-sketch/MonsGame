extends Node3D

func _ready():
	# Dark space environment
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.01, 0.01, 0.02)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.04, 0.06, 0.1)
	env.ambient_light_energy = 0.4
	env.glow_enabled = true
	env.glow_intensity = 0.8
	var we := WorldEnvironment.new()
	we.environment = env
	add_child(we)

	# Sun
	var sun := DirectionalLight3D.new()
	sun.light_energy = 1.5
	sun.transform = Transform3D(Basis(Vector3(0.4, 0.6, 0.7).normalized(), deg_to_rad(35)), Vector3.ZERO)
	add_child(sun)

	# Starfield
	var starfield := preload("res://scripts/Starfield.gd").new()
	add_child(starfield)

	# Planet
	var planet := MeshInstance3D.new()
	var ps := SphereMesh.new()
	ps.radius = 300
	ps.height = 600
	planet.mesh = ps
	planet.transform.origin = Vector3(2500, -600, -3500)
	var pm := StandardMaterial3D.new()
	pm.albedo_color = Color(0.15, 0.35, 0.55)
	pm.metallic = 0.1
	pm.roughness = 0.85
	planet.material_override = pm
	planet.name = "Planet"
	add_child(planet)

	# Atmosphere glow
	var atmo := MeshInstance3D.new()
	var atmo_mesh := SphereMesh.new()
	atmo_mesh.radius = 320
	atmo_mesh.height = 640
	atmo.mesh = atmo_mesh
	atmo.transform = planet.transform
	var am := StandardMaterial3D.new()
	am.albedo_color = Color(0.3, 0.6, 1, 0.12)
	am.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	am.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	atmo.material_override = am
	add_child(atmo)

	# Space station (torus)
	var station := MeshInstance3D.new()
	var ts := TorusMesh.new()
	ts.major_radius = 30
	ts.minor_radius = 3
	station.mesh = ts
	station.transform.origin = Vector3(200, 50, -600)
	var stm := StandardMaterial3D.new()
	stm.albedo_color = Color(0.35, 0.38, 0.42)
	stm.metallic = 0.9
	stm.roughness = 0.2
	stm.emission_enabled = true
	stm.emission = Color(0, 0.3, 0.4, 1)
	stm.emission_energy_multiplier = 0.2
	station.material_override = stm
	station.name = "Station"
	add_child(station)

	# Player ship
	var player := load("res://scenes/PlayerShip.tscn").instantiate()
	add_child(player)
	player.name = "Player"
	player.global_transform.origin = Vector3.ZERO

	# Cockpit camera (first person)
	var cam := Camera3D.new()
	cam.name = "CockpitCamera"
	cam.current = true
	cam.fov = 75
	cam.transform = Transform3D(Basis(), Vector3(0, 0.4, -0.3))
	player.add_child(cam)

	# Connect HUD
	var hud := $HUDLayer/HUD
	hud.ship = player
	hud.radar_contacts = [planet, station]
