extends Node

var player: Player
var EXPLODEDTIME = 0.2
var exploded_timer = 0

func enter():
	exploded_timer = 0

func exit(next_state):
	player.change_to(next_state)

func physics_process(delta):
	player.motion.y += 5
	player.motion.x *= 0.95
	exploded_timer += delta
	if exploded_timer > EXPLODEDTIME:
		exit("InAir")
	post_process()

func post_process():
	pass
