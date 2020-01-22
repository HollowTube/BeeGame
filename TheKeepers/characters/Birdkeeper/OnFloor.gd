extends "res://characters/OnFloor.gd"

#Birdkeeper activation

func post_process(delta):
	if Input.is_action_pressed("ui_down"):
		exit("PreMissile")