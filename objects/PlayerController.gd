extends CharacterBody3D

# player variables
const SPEED = 5.0
var STAMINA = 100
const MAX_STAMINA = 100
const STAMINA_DROP_RATE = 15
const SPRINT_SPEED_MULTIPLIER = 1.5

# camera variables
const CAMERA_ROT_SPEED = 0.01

# signal setup
signal player_running

# objects
@onready var camera = $Camera3D
@onready var ui = $Control

# functions
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var camera_rotation = camera.global_transform.basis.get_euler().y

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# check if player is trying to sprint
	var speed_multiplier = 1.0
	if Input.is_action_pressed("sprint") and STAMINA > 0:
		speed_multiplier = SPRINT_SPEED_MULTIPLIER
		STAMINA = max(0, STAMINA - STAMINA_DROP_RATE * delta)
		emit_signal("player_running", true)
	else:
		emit_signal("player_running", false)

	# apply movement speed
	var speed = SPEED * speed_multiplier

	# move the player
	if direction:
		var rot_direction = direction.rotated(Vector3.UP, camera_rotation)
		velocity.x = rot_direction.x * speed
		velocity.z = rot_direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	# stamina regeneration when player isnt sprinting
	if not Input.is_action_pressed("sprint") and STAMINA < MAX_STAMINA:
		STAMINA = min(MAX_STAMINA, STAMINA + delta * STAMINA_DROP_RATE)

	# debug, remove when we actually update the damn ui
	print(STAMINA)

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
