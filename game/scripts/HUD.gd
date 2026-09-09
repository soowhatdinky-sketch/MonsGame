extends Control

var ship: Node3D
var radar_contacts: Array = []
var font: Font

const CYAN := Color(0, 0.94, 1, 0.9)
const CYAN_DIM := Color(0, 0.5, 0.6, 0.35)
const ORANGE := Color(1, 0.6, 0.1, 0.9)
const RED := Color(1, 0.25, 0.15, 0.9)

var speed := 0.0
var throttle := 0.0
var shields := 100.0
var hull := 100.0
var flight_assist := true
var radar_range := 4000.0

func _ready():
	font = get_theme_default_font()
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _process(_delta):
	if ship and is_instance_valid(ship):
		speed = ship.velocity.length()
		throttle = ship.throttle
		flight_assist = ship.flight_assist
		shields = ship.shields
		hull = ship.hull
	queue_redraw()

func _draw():
	var s := get_size()
	var c := s / 2.0
	_draw_reticle(c)
	_draw_throttle(c)
	_draw_speed(c)
	_draw_shields_hull(s)
	_draw_radar(c, s)
	_draw_corner_brackets(s)
	_draw_status(c)
	_draw_proximity(c, s)

func _draw_reticle(c: Vector2):
	var r := 22.0
	draw_arc(c, r, deg_to_rad(30), deg_to_rad(330), 48, CYAN, 1.5)
	draw_line(c + Vector2(0, -r - 6), c + Vector2(0, -r - 16), CYAN, 1.5)
	draw_line(c + Vector2(0, r + 6), c + Vector2(0, r + 16), CYAN, 1.5)
	draw_line(c + Vector2(-r - 6, 0), c + Vector2(-r - 16, 0), CYAN, 1.5)
	draw_line(c + Vector2(r + 6, 0), c + Vector2(r + 16, 0), CYAN, 1.5)
	draw_circle(c, 1.5, CYAN)

func _draw_throttle(c: Vector2):
	var x := c.x - 55.0
	var h := 65.0
	var y := c.y
	draw_rect(Rect2(x - 3, y - h, 6, h * 2), CYAN_DIM, false, 1.0)
	draw_line(Vector2(x - 5, y), Vector2(x + 5, y), CYAN_DIM, 1.0)
	var fill: float = h * abs(throttle)
	if throttle >= 0:
		draw_rect(Rect2(x - 2, y - fill, 4, fill), CYAN, true)
	else:
		draw_rect(Rect2(x - 2, y, 4, fill), CYAN, true)

func _draw_speed(c: Vector2):
	_draw_text_centered(c + Vector2(0, 52), "%d m/s" % int(speed), 13, CYAN)

func _draw_shields_hull(s: Vector2):
	# Shield arc - bottom left
	var sc := Vector2(55, s.y - 55)
	var sr := 42.0
	draw_arc(sc, sr, PI, 3.0 * PI / 2.0, 24, CYAN_DIM, 2.0)
	var se := PI + (PI / 2.0) * (shields / 100.0)
	draw_arc(sc, sr, PI, se, 24, CYAN, 2.5)
	# Hull arc - bottom right
	var hc := Vector2(s.x - 55, s.y - 55)
	var hr := 42.0
	draw_arc(hc, hr, 3.0 * PI / 2.0, 2.0 * PI, 24, CYAN_DIM, 2.0)
	var he := 3.0 * PI / 2.0 + (PI / 2.0) * (hull / 100.0)
	draw_arc(hc, hr, 3.0 * PI / 2.0, he, 24, CYAN, 2.5)

func _draw_radar(c: Vector2, s: Vector2):
	var rc := Vector2(c.x, s.y - 90)
	var rr := 65.0
	draw_arc(rc, rr, 0, TAU, 64, CYAN_DIM, 1.5)
	draw_arc(rc, rr * 0.5, 0, TAU, 32, CYAN_DIM, 1.0)
	draw_line(rc + Vector2(-rr, 0), rc + Vector2(rr, 0), CYAN_DIM, 0.8)
	draw_line(rc + Vector2(0, -rr), rc + Vector2(0, rr), CYAN_DIM, 0.8)
	if ship and is_instance_valid(ship):
		for contact in radar_contacts:
			if is_instance_valid(contact):
				var c3d := contact as Node3D
				if c3d:
					var rel: Vector3 = ship.global_transform.basis.inverse() * (c3d.global_transform.origin - ship.global_transform.origin)
					var dist: float = Vector2(rel.x, rel.z).length()
					if dist < radar_range:
						var bx: float = rc.x + (rel.x / radar_range) * rr
						var by: float = rc.y + (rel.z / radar_range) * rr
						draw_circle(Vector2(bx, by), 3.0, CYAN)
						draw_arc(Vector2(bx, by), 5.0, 0, TAU, 16, CYAN_DIM, 1.0)

func _draw_corner_brackets(s: Vector2):
	var b := 25.0
	var t := 2.0
	var m := 20.0
	# Top-left
	draw_line(Vector2(m, m), Vector2(m + b, m), CYAN_DIM, t)
	draw_line(Vector2(m, m), Vector2(m, m + b), CYAN_DIM, t)
	# Top-right
	draw_line(Vector2(s.x - m, m), Vector2(s.x - m - b, m), CYAN_DIM, t)
	draw_line(Vector2(s.x - m, m), Vector2(s.x - m, m + b), CYAN_DIM, t)
	# Bottom-left
	draw_line(Vector2(m, s.y - m), Vector2(m + b, s.y - m), CYAN_DIM, t)
	draw_line(Vector2(m, s.y - m), Vector2(m, s.y - m - b), CYAN_DIM, t)
	# Bottom-right
	draw_line(Vector2(s.x - m, s.y - m), Vector2(s.x - m - b, s.y - m), CYAN_DIM, t)
	draw_line(Vector2(s.x - m, s.y - m), Vector2(s.x - m, s.y - m - b), CYAN_DIM, t)

func _draw_status(c: Vector2):
	var fa_txt := "FLIGHT ASSIST: ON" if flight_assist else "FLIGHT ASSIST: OFF"
	var fa_col := CYAN if flight_assist else ORANGE
	_draw_text_centered(c + Vector2(0, -38), fa_txt, 11, fa_col)
	_draw_text_centered(c + Vector2(-78, 4), "%d%%" % int(throttle * 100), 11, CYAN)

func _draw_proximity(c: Vector2, s: Vector2):
	if not ship or not is_instance_valid(ship):
		return
	var closest := INF
	for contact in radar_contacts:
		if is_instance_valid(contact):
			var c3d := contact as Node3D
			if c3d:
				var d: float = (c3d.global_transform.origin - ship.global_transform.origin).length()
				if d < closest:
					closest = d
	if closest < 500:
		var txt := "PROXIMITY: %dm" % int(closest)
		_draw_text_centered(c + Vector2(0, -72), txt, 13, RED if closest < 200 else ORANGE)

func _draw_text_centered(pos: Vector2, text: String, size: int, color: Color):
	if font == null:
		return
	var tw := font.get_string_size(text, 0, -1, size).x
	draw_string(font, pos - Vector2(tw / 2, 0), text, 0, -1, size, color)
