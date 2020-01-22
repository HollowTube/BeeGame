extends Node

var player: Player

func enter():
	pass

func exit(next_state):
	player.change_to(next_state)

func physics_process(delta):

	#Gravity
	player.motion.y = 350
	player.motion.x = 0

	if player.is_on_floor():
		exit("PostDash")
