extends KinematicBody2D

var player: Object

var vel = 0
var motion = Vector2()
var armed = false
var direction = 0
var starting_momentum = 0

remotesync func setPosition(pos, rot):
	position = pos
	rotation = rot

# Called when the node enters the scene tree for the first time.
func _ready():
	
	name = player.name + "grenade" + str(player.missile_counter)
	player.missile_counter += 1
	if player.motion.y <0:
		motion.y = -2*vel + player.motion.y
	else:
		motion.y = -2*vel
	starting_momentum = player.motion.x
	position.x = player.position.x
	position.y = player.position.y - 10

func _physics_process(delta):
	

	#Gravity
	motion.y += 10
	
	motion.x = direction * vel + starting_momentum
	
	var collision = move_and_collide(motion * delta)
	if collision:
		motion = motion.bounce(collision.normal)
		if armed:
			explode()
		armed = true

	if(is_network_master()):
		rpc_unreliable("setPosition",position, rotation)


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	explode()


func explode():
	if(is_network_master()):
		rpc_unreliable("explode_sync")

func _on_TouchArea_body_entered(body):
	if body == player:
		if armed:
			explode()
	elif body is Player:
		explode()

remotesync func explode_sync():
	for player in get_parent().get_node("Players").get_children():
		if player.get_node("TrailSpawnArea").overlaps_area(get_node("ExplosionArea")):
			player.motion = (player.position - position).normalized() *300
			player.change_to("Exploded")
	player.g_state = "exploded"
	queue_free()