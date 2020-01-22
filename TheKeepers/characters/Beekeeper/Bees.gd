extends "res://characters/Trail.gd"

func _physics_process(delta):
	$Sprite.position += Vector2(rng.randi()%2-0.5, rng.randi()%2-0.5)