extends Node

var player: Player

var T_VELOCITY = 250
var J_VELOCITY = 100
var H_ACC = 20
var FRICT = 0.95

func enter():
	pass

func exit(next_state):
	player.change_to(next_state)

func physics_process(delta):
	#Gravity
	player.motion.y += 10
	
	if(is_network_master()):
		if not Input.is_action_pressed("ui_up"):
			player.motion.y = clamp(player.motion.y, -J_VELOCITY, T_VELOCITY)
		
		if Input.is_action_pressed("ui_right"):
			player.motion.x += H_ACC
		elif Input.is_action_pressed("ui_left"):
			player.motion.x -= H_ACC
		else:
			player.motion.x *= FRICT
	
	player.motion.y = clamp(player.motion.y, -T_VELOCITY, T_VELOCITY)
	player.motion.x = clamp(player.motion.x, -120, 120)
	
	if player.is_on_floor():
		player.change_to("OnFloor")
	post_process()

func post_process():
	pass
