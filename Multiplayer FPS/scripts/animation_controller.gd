extends Node3D
class_name AnimationController

@onready var anim_player = $"../AnimationPlayer"
@onready var anim_state: AnimationState = AnimationState.IDLE
@onready var punch_timer = $"../PunchTimer"
@export var punch_anim_duration = 0.833

var is_punching: bool = false 

enum AnimationState
{
	IDLE,
	WALKING,
	RUNNING,
	JUMPING,
	PUNCHING
}

func _ready():
	punch_timer.wait_time = punch_anim_duration

func set_anim_state(new_state: AnimationState):
	if !is_punching:
		anim_state = new_state
		match anim_state:
			AnimationState.PUNCHING:
				anim_player.play("RobotArmature|Robot_Punch")
				punch_timer.start()
				is_punching = true
			AnimationState.IDLE:
				anim_player.play("RobotArmature|Robot_Idle")
			AnimationState.WALKING:
				anim_player.play("RobotArmature|Robot_Walking")
			AnimationState.RUNNING:
				anim_player.play("RobotArmature|Robot_Running")
			AnimationState.JUMPING:
				anim_player.play("RobotArmature|Robot_Jump")
		

func _on_punch_timer_timeout():
	is_punching = false
