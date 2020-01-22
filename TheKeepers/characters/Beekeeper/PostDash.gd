extends Node

var player: Player

var POSTDASH_TIMER = 0.1
var postdash_time = 0

var bullet_scene = preload("res://characters/Beekeeper/Bullet.tscn")

remotesync func spawnBullets(id):
	var bullet = bullet_scene.instance()
	bullet.set_network_master(int(id))
	bullet.direction = "right"
	bullet.player = get_tree().get_root().get_node("Game/Players/" + id)
	get_tree().get_root().get_node("Game").add_child(bullet)
	
	var bullet2 = bullet_scene.instance()
	bullet2.set_network_master(int(id))
	bullet2.direction = "left"
	bullet2.player = get_tree().get_root().get_node("Game/Players/" + id)
	get_tree().get_root().get_node("Game").add_child(bullet2)

func enter():
	postdash_time = 0

	if(is_network_master()):
		rpc_unreliable("spawnBullets", player.name)


func exit(next_state):
	player.change_to(next_state)

func physics_process(delta):

	#Gravity
	player.motion.y = 0
	player.motion.x = 0
	
	postdash_time += delta
	
	if postdash_time > POSTDASH_TIMER:
		exit("OnFloor")
