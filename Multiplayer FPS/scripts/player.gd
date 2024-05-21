extends CharacterBody3D

# Reference to camera 
@onready var camera = $camera

const SPEED = 5.5
const JUMP_VELOCITY = 4.5

# Camera view limits 
const UPPER_VIEW_LIMIT: float = PI/2
const LOWER_VIEW_LIMIT: float = -PI/2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	# Lock the mouse 
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Rotate player on y-axis
		rotate_y(-event.relative.x * 0.005)
		# Rotate camera on x-axis 
		camera.rotate_x(-event.relative.y * 0.005)
		# Limit camera angles 
		camera.rotation.x = clamp(camera.rotation.x, LOWER_VIEW_LIMIT, UPPER_VIEW_LIMIT) 

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
