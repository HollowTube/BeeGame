extends Node

var player: Player
var FLOORTIME = 0.1
var floor_timer = 0

func enter():
	floor_timer = 0

func exit(next_state):
	player.change_to(next_state)

func physics_process(delta):

	#Gravity
	player.motion.y += 10

	if(is_network_master()):
		#Horizontal movement
		if Input.is_action_pressed("ui_right"):
			player.motion.x = 120

		elif Input.is_action_pressed("ui_left"):
			player.motion.x = -120
		else:
			player.motion.x = 0

		#Jumping
		if Input.is_action_pressed("ui_up"):
			player.motion.y = -230

	if player.is_on_floor():
		floor_timer = 0
	else:
		floor_timer += delta
		if floor_timer > FLOORTIME:
			exit("InAir")
			
	post_process(delta)
	
func post_process(delta):
	pass