extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_shape_exited(body_id, body, body_shape, area_shape):
	if (body.get_name() == "Player" or body.get_name() == "Player2"):
		if body.position.x > position.x:
			get_node("Sprite").set_flip_h(false)
		else:
			get_node("Sprite").set_flip_h(true)
		$AnimationPlayer.play("grass")


func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	if area:
		if "Bullet" in area.get_parent().get_name():
			if area.get_parent().direction == "right":
				get_node("Sprite").set_flip_h(false)
			if area.get_parent().direction == "left":
				get_node("Sprite").set_flip_h(true)
			$AnimationPlayer.play("grass")
		if "Bird" in area.get_parent().get_name():
			print(area.get_parent().rotation)
			var rotation = area.get_parent().rotation - area.get_parent().rotation/(2*PI)
			if rotation > 0:
				if rotation < (PI/2) || rotation > (3*PI/2):
					get_node("Sprite").set_flip_h(false)
				else:
					get_node("Sprite").set_flip_h(true)
			if rotation < 0:
				if rotation > (-PI/2) || rotation < (-3*PI/2):
					get_node("Sprite").set_flip_h(false)
				else:
					get_node("Sprite").set_flip_h(true)
			$AnimationPlayer.play("grass")