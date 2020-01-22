extends Node

var player: Player

var missile_scene = preload("res://characters/Birdkeeper/Missile.tscn")

var missile : Object

remotesync func spawnMissile(id):
	missile = missile_scene.instance()
	missile.set_network_master(int(id))
	missile.player = get_tree().get_root().get_node("Game/Players/" + id)
	get_tree().get_root().get_node("Game").add_child(missile)

func enter():
	if(is_network_master()):
		rpc_unreliable("spawnMissile", player.name)

func exit(next_state):
	player.change_to(next_state)

func physics_process(delta):

	#Gravity
	player.motion.y = 0
	player.motion.x = 0

	if(is_network_master()):
		if Input.is_action_pressed("ui_right"):
			missile.rotation_dir = 1
		elif Input.is_action_pressed("ui_left"):
			missile.rotation_dir = -1
		else:
			missile.rotation_dir = 0
			
		if not Input.is_action_pressed("ui_down"):
			missile.rotation_dir = 0
			exit("OnFloor")
