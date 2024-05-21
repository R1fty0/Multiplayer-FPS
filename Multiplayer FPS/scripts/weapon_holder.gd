extends Node3D

@export var player: CharacterBody3D
@export var weapon_anim_player: AnimationPlayer 

# To-Do: Make shooting a signal, wait for shooting animation to finish before doing anything else 



func _process(delta):
	if Input.is_action_pressed("fire1"):
		# Play shoot animation 
		weapon_anim_player.play("shoot")
	elif player.velocity.length() == 0.0:
		# Play idle animation when player is not moving 
		weapon_anim_player.play("idle")
	elif player.velocity.length() >= 0.0:
		# Play move animation when player is moving 
		weapon_anim_player.play("move")
	

