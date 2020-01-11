extends KinematicBody2D

var Bees = preload("res://Bees.tscn")
var Bullet = preload("res://Bullet.tscn")

var timer = Timer.new()
var timer2 = Timer.new()

var deathPosX
var deathPosY

export var player_number = 1

var motion = Vector2()
var UP
var RIGHT
var LEFT
var DOWN
var floor_timer = 0;
<<<<<<< HEAD
var dead = false
=======
var dashing = false;
var dash_timer = 0;
>>>>>>> 208b0096d2bea549314dd8020d626282a261c1fa

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
	timer2.connect("timeout",self,"_timeout")
	add_child(timer) #to process
	add_child(timer2)
	timer.start(0.05) #to start


func foo():
	pass 

func spawn_bee():
    # "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = Bees.instance()
	b.global_position = global_position
	b.player_number = player_number
	get_parent().add_child(b)

func spawn_bullet():
    # "Muzzle" is a Position2D placed at the barrel of the gun.
	var a = Bullet.instance()
	a.global_position = global_position
	a.direction ="left"
	a.player_number = player_number
	get_parent().add_child(a)
	
	var b = Bullet.instance()
	b.global_position = global_position
	b.direction = "right"
	b.player_number = player_number
	get_parent().add_child(b)


func _physics_process(delta):
	
	motion.y += 10
	
	if dead:
		global_position.x = deathPosX + randi()%4-2
		global_position.y = deathPosY + randi()%4-2
		return
	
	if is_on_floor():
		floor_timer = 0;
	
	floor_timer += delta
	
	if floor_timer < 0.1:
		
		if Input.is_action_pressed(UP):
			motion.y = -230
			get_node("AnimationPlayer").play("jump")
		
		if Input.is_action_pressed(RIGHT):
			motion.x = 120
		elif Input.is_action_pressed(LEFT):
			motion.x = -120
		else:
			motion.x = 0
			
		if dashing == true:
			spawn_bullet()
			dashing = false
			dash_timer = 0
		
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
		
		if Input.is_action_pressed(DOWN):
			dashing = true
		
		if dashing == true:
			motion.x =0
			motion.y =0
			dash_timer += delta
			if dash_timer > 0.2:
				motion.x = 0
				motion.y = 350
				


		motion.x = clamp(motion.x, -120, 120)
		
		
	motion = move_and_slide(motion, Vector2(0, -1))
	
func _on_timer_timeout():
	spawn_bee()
	timer.start(0.05)
	
func _timeout():
	print("timed out!")
	dead = false
	get_tree().reload_current_scene()
	
func die():
	timer2.start(1)
	deathPosX = global_position.x
	deathPosY = global_position.y
	dead = true
	#Engine.time_scale = 0.1
	#while(timer2.time_left!=0):
	#	print(timer2.time_left)
	#	global_position.x = global_position.x + randi()%2-0.5
	#	global_position.y = global_position.y + randi()%2-0.5
	#print(get_node("Sprite"))
	#get_tree().reload_current_scene()