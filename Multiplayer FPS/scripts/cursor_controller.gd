extends Node

var mouse_locked: bool = false

func _ready():
	hide_mouse() 

func _input(event):
	if event.is_action_pressed("show_cursor") and mouse_locked:
		show_mouse()
	elif event.is_action_pressed("show_cursor") and !mouse_locked:
		hide_mouse()
	
func show_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	mouse_locked = false
	
func hide_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_locked = true
