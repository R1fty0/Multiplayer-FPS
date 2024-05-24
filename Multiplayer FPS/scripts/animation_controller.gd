extends Node3D
class_name AnimationController

@onready var anim_player = $"../AnimationPlayer"
@onready var anim_state: AnimationState = AnimationState.IDLE

enum AnimationState
{
	IDLE,
	WALKING,
	RUNNING,
	JUMPING,
	PUNCHING
}

func set_anim_state(new_state: AnimationState):
	anim_state = new_state
	

func _process(delta):
	match anim_state:
		AnimationState.IDLE:
			anim_player.play("RobotArmature|Robot_Idle")
		AnimationState.WALKING:
			anim_player.play("RobotArmature|Robot_Walking")
		AnimationState.RUNNING:
			anim_player.play("RobotArmature|Robot_Running")			
		AnimationState.JUMPING:
			anim_player.play("RobotArmature|Robot_Jump")
		AnimationState.PUNCHING:
			anim_player.play("RobotArmature|Robot_Punch")
	print(anim_state)
