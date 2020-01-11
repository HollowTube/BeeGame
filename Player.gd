extends KinematicBody2D

var Bees = preload("res://Bees.tscn")

var timer = Timer.new()

export var player_number = 1

var motion = Vector2()
var UP
var RIGHT
var LEFT
var DOWN
var floor_timer = 0;

func _ready():
	
	if player_number == 1 :
		UP = "ui_up"
		RIGHT = "ui_right"
		DOWN = "ui_down"
		LEFT = "ui_left"
	if player_number == 2 :
		UP = "ui_up_2"
		RIGHT = "ui_right_2"
		DOWN = "ui_down_2"
		LEFT = "ui_left_2"

	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.start(0.05) #to start


func spawn_bee():
    # "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = Bees.instance()
	b.global_position = global_position
	b.player_number = player_number
	get_parent().add_child(b)

func _physics_process(delta):
	
	motion.y += 10
	
	if is_on_floor():
		floor_timer = 0;
	
	floor_timer += delta
	
	if floor_timer < 0.1:
		
		if Input.is_action_pressed(UP):
			motion.y = -230
			#get_node("AnimationPlayer").play("jump")
		
		if Input.is_action_pressed(RIGHT):
			motion.x = 120
		elif Input.is_action_pressed(LEFT):
			motion.x = -120
		else:
			motion.x = 0
	else:
		if Input.is_action_pressed(UP):
			motion.y = clamp(motion.y, -250, 250)
		else:
			motion.y = clamp(motion.y, -100, 250)
		
		if Input.is_action_pressed(RIGHT):
			motion.x += 20
			get_node("Sprite").set_flip_h(true)
		elif Input.is_action_pressed(LEFT):
			motion.x -= 20
			get_node("Sprite").set_flip_h(false)
		else:
			motion.x = motion.x * 0.95
		
		motion.x = clamp(motion.x, -120, 120)
		
		
	motion = move_and_slide(motion, Vector2(0, -1))
	
	

func _on_timer_timeout():
	spawn_bee()
	timer.start(0.05)
	
func die():
	get_tree().reload_current_scene()