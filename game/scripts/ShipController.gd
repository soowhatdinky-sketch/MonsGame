extends Node3D

# --- Flight parameters ---
@export var max_speed := 300.0
@export var base_accel := 60.0
@export var rot_speed := 1.5
@export var boost_mult := 3.0

# --- State (read by HUD) ---
var velocity := Vector3.ZERO
var throttle := 0.0
var shields := 100.0
var hull := 100.0
var flight_assist := true

# --- Internal ---
var mouse_motion := Vector2.ZERO
var engine_glow: MeshInstance3D
var dash_strip: MeshInstance3D

func _ready():
	_build_ship()

func _build_ship():
	var dark := StandardMaterial3D.new()
	dark.albedo_color = Color(0.06, 0.08, 0.1)
	dark.metallic = 0.85
	dark.roughness = 0.25

	# Hull
	var hull_mesh := MeshInstance3D.new()
	var cap := CapsuleMesh.new()
	cap.radius = 0.6
	cap.height = 2.5
	hull_mesh.mesh = cap
	hull_mesh.rotate_x(PI / 2)
	hull_mesh.material_override = dark
	add_child(hull_mesh)

	# Engine glow
	engine_glow = MeshInstance3D.new()
	var eg := SphereMesh.new()
	eg.radius = 0.35
	engine_glow.mesh = eg
	engine_glow.transform.origin = Vector3(0, 0, 1.3)
	var gm := StandardMaterial3D.new()
	gm.albedo_color = Color(0, 0.85, 1, 0.8)
	gm.emission_enabled = true
	gm.emission = Color(0, 0.85, 1, 1)
	gm.emission_energy_multiplier = 2.0
	gm.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	engine_glow.material_override = gm
	add_child(engine_glow)

	# Cockpit dashboard (visible at bottom of screen)
	var dash := MeshInstance3D.new()
	var db := BoxMesh.new()
	db.size = Vector3(2.8, 0.35, 0.7)
	dash.mesh = db
	dash.transform.origin = Vector3(0, -0.35, -0.7)
	dash.material_override = dark
	add_child(dash)

	# Cyan glow strip on dashboard
	dash_strip = MeshInstance3D.new()
	var sb := BoxMesh.new()
	sb.size = Vector3(2.2, 0.03, 0.04)
	dash_strip.mesh = sb
	dash_strip.transform.origin = Vector3(0, -0.17, -0.35)
	var sm := StandardMaterial3D.new()
	sm.albedo_color = Color(0, 0.94, 1, 1)
	sm.emission_enabled = true
	sm.emission = Color(0, 0.94, 1, 1)
	sm.emission_energy_multiplier = 2.5
	dash_strip.material_override = sm
	add_child(dash_strip)

	# Canopy side frames (visible at screen edges)
	for sign in [-1.0, 1.0]:
		var frame := MeshInstance3D.new()
		var fb := BoxMesh.new()
		fb.size = Vector3(0.08, 0.7, 1.8)
		frame.mesh = fb
		frame.transform.origin = Vector3(sign * 0.95, 0.15, -1.0)
		frame.material_override = dark
		add_child(frame)

	# Interior light
	var il := OmniLight3D.new()
	il.light_energy = 0.4
	il.light_color = Color(0, 0.3, 0.4)
	il.transform.origin = Vector3(0, 0.2, -0.5)
	il.omni_range = 3.0
	add_child(il)

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_motion += event.relative
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_ESCAPE:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
			KEY_X:
				flight_assist = !flight_assist

func _physics_process(delta: float):
	var pitch := 0.0
	var yaw := 0.0
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		pitch = clamp(-mouse_motion.y * 0.003, -1.5, 1.5)
		yaw = clamp(-mouse_motion.x * 0.003, -1.5, 1.5)
	else:
		var vp := get_viewport()
		if vp:
			var off := (vp.get_mouse_position() - vp.size / 2.0) / (vp.size / 2.0)
			var dz := 0.08
			off.x = 0 if abs(off.x) < dz else (off.x - dz * sign(off.x)) / (1 - dz)
			off.y = 0 if abs(off.y) < dz else (off.y - dz * sign(off.y)) / (1 - dz)
			pitch = -off.y * 1.2
			yaw = -off.x * 1.2
	mouse_motion = Vector2.ZERO

	var roll := 0.0
	if Input.is_physical_key_pressed(KEY_A): roll += 1.0
	if Input.is_physical_key_pressed(KEY_D): roll -= 1.0

	var target_throttle := 0.0
	if Input.is_physical_key_pressed(KEY_W): target_throttle += 1.0
	if Input.is_physical_key_pressed(KEY_S): target_throttle -= 1.0
	throttle = lerp(throttle, target_throttle, 3.0 * delta)

	var lat := 0.0
	if Input.is_physical_key_pressed(KEY_Q): lat -= 1.0
	if Input.is_physical_key_pressed(KEY_E): lat += 1.0

	var vert := 0.0
	if Input.is_physical_key_pressed(KEY_R): vert += 1.0
	if Input.is_physical_key_pressed(KEY_F): vert -= 1.0

	var boosting := Input.is_physical_key_pressed(KEY_SHIFT)

	# Rotation
	rotate_x(pitch * rot_speed * delta)
	rotate_z(roll * rot_speed * delta)
	rotate_y(yaw * rot_speed * delta)

	# Thrust
	var accel := base_accel * (boost_mult if boosting else 1.0)
	var fwd := -transform.basis.z
	var right := transform.basis.x
	var up := transform.basis.y
	velocity += fwd * throttle * accel * delta
	velocity += right * lat * accel * 0.6 * delta
	velocity += up * vert * accel * 0.6 * delta

	# Speed cap
	var max_v := max_speed * (boost_mult if boosting else 1.0)
	if velocity.length() > max_v:
		velocity = velocity.normalized() * max_v

	# Flight assist damping
	if flight_assist:
		var damp := 0.8 * delta
		if abs(throttle) < 0.01 and abs(lat) < 0.01 and abs(vert) < 0.01:
			velocity = velocity.lerp(Vector3.ZERO, damp)
		else:
			var lv := transform.basis.inverse() * velocity
			lv.x = lerp(lv.x, 0.0, damp)
			lv.y = lerp(lv.y, 0.0, damp)
			velocity = transform.basis * lv

	global_translate(velocity * delta)

	# Engine visual
	var intensity := abs(throttle) + (1.0 if boosting else 0.0)
	if engine_glow and engine_glow.material_override:
		engine_glow.material_override.emission_energy_multiplier = 0.3 + intensity * 3.0
		engine_glow.scale = Vector3.ONE * (0.4 + intensity * 0.6)
	if dash_strip and dash_strip.material_override:
		dash_strip.material_override.emission_energy_multiplier = 1.0 + intensity * 1.5
