extends Player

var missile_counter = 0
var grenade_scene =  preload("res://characters/Fishkeeper/Grenade.tscn")
var grenade_line = preload("res://characters/Fishkeeper/GrenadeLine.tscn")
var grenade : Object
var spawned_line = false
var line : Object

var g_state = "none"
var g_vel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	trail_scene = preload("res://characters/Fishkeeper/Fishes.tscn")
	modulate = Color(0,0,1)

remotesync func spawnGrenade(id, vel):
	grenade = grenade_scene.instance()
	grenade.set_network_master(int(id))
	grenade.vel = vel
	grenade.direction = facing
	grenade.player = get_tree().get_root().get_node("Game/Players/" + id)
	get_tree().get_root().get_node("Game").add_child(grenade)

func _physics_process(delta):

	if(is_network_master()):
		if Input.is_action_pressed("ui_down"):
			match g_state:
				"none":
					g_vel += 20
					g_state = "aiming"
				"aiming":
					g_vel += 3
				"thrown":
					grenade.explode()
					g_state = "exploded"
		else:
			match g_state:
				"exploded":
					g_state = "none"
				"aiming":
					rpc_unreliable("spawnGrenade", name, g_vel)
					g_state = "thrown"
					g_vel = 0
					spawned_line = false
					line.queue_free()
	
	g_vel = clamp(g_vel, 20, 175)

	if g_state == "aiming":
		if spawned_line == false:
			line = grenade_line.instance()
			line.velocity.x = g_vel *1.5*facing
			line.velocity.y = -g_vel*2
			add_child(line)
			spawned_line = true
		else:
			line.velocity.x = g_vel *1*facing
			line.velocity.y = -g_vel*2
