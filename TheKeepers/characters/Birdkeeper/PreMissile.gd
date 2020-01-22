extends Node

var player: Player

var PREMISSILE_TIMER = 0.5
var premissile_time = 0

func enter():
	premissile_time = 0

func exit(next_state):
	player.change_to(next_state)

func physics_process(delta):

	#Gravity
	player.motion.y = 0
	player.motion.x = 0
	
	premissile_time += delta
	
	if premissile_time > PREMISSILE_TIMER:
		exit("MissileControl")
