extends CharacterBody3D

@export_category("Movement")
@export var walk_speed = 5.0
@export var run_speed = 8.0
@export var jump_velocity = 4.5
@export var deacceleration_speed = 5.0
@export var gravity = 9.81

@export_category("Camera")
@export var sensitivity = 0.5
@export var max_view_angle = 45
@export var min_view_angle = -90

@export_category("References")
@export var pivot: Marker3D
@export var anim_controller: AnimationController

var is_walking: bool = false
var current_speed: float = 0.0

func _ready():
	# Lock mouse 
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		# Rotate camera and player based off of mouse motion
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		pivot.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(min_view_angle), deg_to_rad(max_view_angle))
	
	if event.is_action_pressed("run"):
		if is_walking:
			is_walking = false
		elif !is_walking:
			is_walking = true
	
	# Quit game.
	if event.is_action_pressed("quit"):
		get_tree().quit()
	
	
		
func _physics_process(delta):
	movement()
	jumping(delta)
		
func jumping(delta):
	# Apply Gravity To Player.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

func movement():
	# Get movement direction 
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Move player.
	if direction:
		if is_walking:
			current_speed = walk_speed
			anim_controller.set_anim_state(anim_controller.AnimationState.WALKING)
		else:
			current_speed = run_speed
			anim_controller.set_anim_state(anim_controller.AnimationState.RUNNING)
				
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	
	# Bring player to stop.
	else:
		velocity.x = move_toward(velocity.x, 0, deacceleration_speed)
		velocity.z = move_toward(velocity.z, 0, deacceleration_speed)
	
	if velocity.length() == 0.0:
		anim_controller.set_anim_state(anim_controller.AnimationState.IDLE)
		
	# Apply movement
	move_and_slide()
