extends KinematicBody

# Simple first-person controller for Godot 3.x.
# Uses raw key checks (no InputMap required) so it runs without editor setup.

export (float) var speed := 6.0
export (float) var mouse_sensitivity := 0.15

var velocity := Vector3()
onready var cam := $Camera
var rotation_x := 0.0

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
    if event is InputEventKey:
        if event.scancode == KEY_ESCAPE and event.pressed:
            # release mouse
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    if event is InputEventMouseMotion:
        rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
        rotation_x = clamp(rotation_x + deg2rad(-event.relative.y * mouse_sensitivity), deg2rad(-80), deg2rad(80))
        cam.rotation.x = rotation_x

func _physics_process(delta):
    var dir := Vector3()
    var forward := -transform.basis.z
    var right := transform.basis.x

    if Input.is_key_pressed(KEY_W):
        dir += forward
    if Input.is_key_pressed(KEY_S):
        dir -= forward
    if Input.is_key_pressed(KEY_A):
        dir -= right
    if Input.is_key_pressed(KEY_D):
        dir += right

    if dir.length() > 0:
        dir = dir.normalized() * speed
    velocity = move_and_slide(dir, Vector3.UP)

func _unhandled_input(event):
    # allow recapture of the mouse
    if event is InputEventMouseButton and event.pressed:
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
