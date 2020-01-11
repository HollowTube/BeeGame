extends KinematicBody2D

var Bees = preload("res://Bees.tscn")

var timer = Timer.new()

const UP = Vector2(0, -1)
var motion = Vector2()

func keep():
    # "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = Bees.instance()
	b.global_position = global_position
	get_parent().add_child(b)

func _physics_process(delta):
	if is_on_floor():
		
		if Input.is_action_pressed("ui_up"):
			motion.y = -250
			#get_node("AnimationPlayer").play("jump")
		
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
		
		if Input.is_action_pressed("ui_right"):
			motion.x += 20
			get_node("Sprite").set_flip_h(true)
		elif Input.is_action_pressed("ui_left"):
			motion.x -= 20
			get_node("Sprite").set_flip_h(false)
		else:
			motion.x = motion.x * 0.95
		
		motion.x = clamp(motion.x, -120, 120)
		
		
	motion = move_and_slide(motion, UP)
	

func _ready():
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.start(0.05) #to start

func _on_timer_timeout():
	keep()
	timer.start(0.05)