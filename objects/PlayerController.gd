extends CharacterBody3D

# player variables
const SPEED = 5.0

# camera variables
const CAMERA_ROT_SPEED = 0.01

@onready var camera = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var camera_rotation = camera.global_transform.basis.get_euler().y

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		var rot_direction = direction.rotated(Vector3.UP, camera_rotation)
		velocity.x = rot_direction.x * SPEED
		velocity.z = rot_direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

# input handlers
func _input(event):
	# ESCAPE UNLOCKS MOUSE
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# CAMERA BEHAVIOR
	if event is InputEventMouseMotion:
		# rotate the camera
		camera.rotate_y( - event.relative.x * CAMERA_ROT_SPEED)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -20, 20)
