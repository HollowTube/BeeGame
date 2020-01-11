extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

func _physics_process(delta):
	
	if is_on_floor():
		
		if Input.is_action_pressed("ui_up"):
			motion.y = -250
		
		if Input.is_action_pressed("ui_right"):
			motion.x = 120
		elif Input.is_action_pressed("ui_left"):
			motion.x = -120
		else:
			motion.x = 0
	else:
		if Input.is_action_pressed("ui_up"):
			motion.y = clamp(motion.y + 10, -250, 250)
		else:
			motion.y = clamp(motion.y + 10, -100, 250)
	
		
	motion = move_and_slide(motion, UP)
	
	pass