extends RigidBody3D

@onready var twist: Node3D = $Twist
@onready var pitch: Node3D = $Twist/Pitch
#@onready var player: RigidBody3D = $"."

var sensitivity := 0.001
var inputTwist := 0.0
var inputPitch := 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("LEFT", "RIGHT")
	input.z = Input.get_axis("FORWARD", "BACK")
	
	apply_central_force(twist.basis * input * 1200.0 * delta)

	if Input.is_action_just_pressed("EXIT"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#player.rotate_y(inputTwist)
	twist.rotate_y(inputTwist)
	pitch.rotate_x(inputPitch)
	pitch.rotation.x = clamp(pitch.rotation.x, deg_to_rad(-30), deg_to_rad(30))
	inputPitch = 0
	inputTwist = 0
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			inputTwist = - event.relative.x * sensitivity
			inputPitch = - event.relative.y * sensitivity
