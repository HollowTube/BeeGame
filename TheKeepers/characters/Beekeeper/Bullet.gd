extends Node2D

var player: Object

var direction
var h_motion

remotesync func setPosition(pos):
	position = pos

# Called when the node enters the scene tree for the first time.
func _ready():
	
	name = player.name + "bullet" + str(player.bullet_counter)
	player.bullet_counter += 1

	position = player.position
	if direction == "right":
		$Sprite.set_flip_h(true)
		h_motion = 350
	elif direction == "left":
		h_motion = -350

func _physics_process(delta):
	
	position.x += h_motion*delta 
	if(is_network_master()):
		rpc_unreliable("setPosition",position)


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()

func _on_Area2D_body_entered(body):
	if body != player and body.has_method("die"):
		body.change_to("Dead")
