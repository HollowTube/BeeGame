extends "res://characters/InAir.gd"

#Beekeeper Dash activation

func post_process():
	if Input.is_action_pressed("ui_down"):
		exit("PreDash")