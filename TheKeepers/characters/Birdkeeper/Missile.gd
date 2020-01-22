extends Node2D

var player: Object

var speed = 3
var rotation_speed = 4
var rotation_dir = 0

remotesync func setPosition(pos, rot):
	position = pos
	rotation = rot

# Called when the node enters the scene tree for the first time.
func _ready():
	
	name = player.name + "missile" + str(player.missile_counter)
	player.missile_counter += 1

	position = player.position

func _physics_process(delta):
	
	var velocity = Vector2()
	velocity = Vector2(speed, 0).rotated(rotation)
	rotation += rotation_dir * rotation_speed * delta
	position += velocity
	
	if(is_network_master()):
		rpc_unreliable("setPosition",position, rotation)


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()

func _on_Area2D_body_entered(body):
	if body != player and body.has_method("die"):
		body.change_to("Dead")
