extends Control	

const HOST_SCENE: PackedScene = preload("res://scenes/host_menu.tscn")


func _on_host_button_pressed():
	pass # Replace with function body.


func _on_join_button_pressed():
	pass # Replace with function body.


# Quit/Close Game
func _on_quit_button_pressed():
	get_tree().quit()
