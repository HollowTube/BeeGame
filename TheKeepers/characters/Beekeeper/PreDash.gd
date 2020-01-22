extends Node

var player: Player

var PREDASH_TIMER = 0.2
var predash_time = 0

func enter():
	predash_time = 0

func exit(next_state):
	player.change_to(next_state)

func physics_process(delta):

	#Gravity
	player.motion.y = 0
	player.motion.x = 0
	
	predash_time += delta
	
	if predash_time > PREDASH_TIMER:
		exit("Dashing")
