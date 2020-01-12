extends KinematicBody2D

var start = false

var Bird = preload("res://Bird.tscn")
var Bees = preload("res://Bees.tscn")
var Bullet = preload("res://Bullet.tscn")
var LandingDust = preload("res://LandingDust.tscn")

var air = false

var timer = Timer.new()

var guide_timer = 0

var deathPosX
var deathPosY

export var player_number = 1

var birddead = true


var motion = Vector2()
var UP
var RIGHT
var LEFT
var DOWN
var bird
var floor_timer = 0;
var dead = false
var dashing = false;
var post_dashing = false;
var guiding = false;
var post_guiding = false;
var dash_timer = 0;
var state = ""

func _ready():
	
	if player_number == 2 :
		UP = "ui_up"
		RIGHT = "ui_right"
		DOWN = "ui_down"
		LEFT = "ui_left"
	if player_number == 1 :
		UP = "ui_up_2"
		RIGHT = "ui_right_2"
		DOWN = "ui_down_2"
		LEFT = "ui_left_2"


	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer) #to process
	timer.start(0.05) #to start

	if player_number == 1:
		get_node("Sprite").set_flip_h(true)

	if player_number == 2:
	 	$Sprite.texture = preload("res://assets/char2_sheet.png")


func foo():
	pass 

func spawn_dust():
    # "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = LandingDust.instance()
	b.global_position = global_position
	get_parent().add_child(b)

func spawn_bee():
    # "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = Bees.instance()
	b.global_position = global_position
	b.player_number = player_number
	get_parent().add_child(b)

func spawn_bullet():
    # "Muzzle" is a Position2D placed at the barrel of the gun.
	var a = Bullet.instance()
	a.get_node("Bullet").global_position = global_position
	a.get_node("Bullet").direction ="left"
	a.get_node("Bullet").player_number = player_number
	get_parent().add_child(a)
	
	var b = Bullet.instance()
	b.get_node("Bullet").global_position = global_position
	b.get_node("Bullet").direction = "right"
	b.get_node("Bullet").player_number = player_number
	get_parent().add_child(b)

func _physics_process(delta):
	
	if start == true:
		
		motion.y += 10
		
		if dead:
			global_position.x = deathPosX + randi()%2-1
			global_position.y = deathPosY + randi()%2-1
			return
		
		if is_on_floor():
		
			if air == true:
				spawn_dust()
		
			air = false
		
			if dashing == true:
				dash_timer = 0
				post_dashing = true
				spawn_bullet()
				get_node("../Camera2D").shake(0.3)
				for i in range(1, 15):
					get_node("../grass/grass" + str(i)).play_grass(global_position)
				dashing = false
				dash_timer = 0
				$AnimationPlayer.play("slam")
			
			elif post_dashing == true:
				motion.x =0
				motion.y =0
				dash_timer += delta
				if dash_timer > 0.3:
					post_dashing = false
					dash_timer = 0
		
			else:
				if Input.is_action_pressed(RIGHT):
					
					motion.x = 120
					$AnimationPlayer.play("run")
					get_node("Sprite").set_flip_h(true)
					state = "walk"
				
				elif Input.is_action_pressed(LEFT):
				
					motion.x = -120
					$AnimationPlayer.play("run")
					get_node("Sprite").set_flip_h(false)
					state = "walk"
				
				else:
					motion.x = 0
					if state == "walk":
						$AnimationPlayer.play("idle")
	
			if player_number == 2:
				if Input.is_action_pressed(DOWN):
					if guiding == false:
						guiding = true
						$AnimationPlayer.play("charging")
					elif post_guiding == false:
						motion.x = 0
						guide_timer += delta
						
						if guide_timer > 0.5:
							
							bird = Bird.instance()
							bird.get_node("Bird").global_position = global_position
							get_parent().add_child(bird)
							birddead = false
							get_node("../Camera2D").shake(0.3)
							for i in range(1, 15):
								get_node("../grass/grass" + str(i)).play_grass(global_position)
							
							post_guiding = true
					elif post_guiding == true:
						$AnimationPlayer.play("slam_fall")
						motion.x = 0
						if birddead == false:
							if Input.is_action_pressed(RIGHT):
								bird.get_node("Bird").rotation_dir = 1
							elif Input.is_action_pressed(LEFT):
								bird.get_node("Bird").rotation_dir = -1
							else:
								bird.get_node("Bird").rotation_dir = 0
				else:
					if guiding == true:
						guide_timer =0
						guiding = false
						post_guiding = false
						if birddead == false:
							bird.get_node("Bird").rotation_dir = 0
			floor_timer = 0;
		
		floor_timer += delta
		
		if floor_timer < 0.1:
		
				
			if Input.is_action_pressed(UP):
				
				motion.y = -230
				$AnimationPlayer.play("jump")
	
				
	
					
			
		else:
			air = true
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
			
			if (state == "walk" or state == "idle") and motion.y > 0:
				state = "startfall"
			
			if state == "startfall":
				$AnimationPlayer.play("falling")
				state = "endfall"
				
			if Input.is_action_pressed(DOWN) and player_number ==1:
				dashing = true
			
			if dashing == true:
				motion.x =0
				motion.y =0
				dash_timer += delta
				$AnimationPlayer.play("charging")
				if dash_timer > 0.2:
					$AnimationPlayer.play("slam_fall")
					motion.x = 0
					motion.y = 350
					
	
	
			motion.x = clamp(motion.x, -120, 120)
			
			
		motion = move_and_slide(motion, Vector2(0, -1))
		
		global_position.x = clamp(global_position.x, 5, 507) 
	
func _on_timer_timeout():
	if start == true:
		spawn_bee()
	timer.start(0.1)
	
func die():
	deathPosX = global_position.x
	deathPosY = global_position.y
	get_node("../Camera2D").zoomIn(global_position)
	
	dead = true
	
	var b = load("res://vn2.tscn").instance()
	get_parent().get_parent().get_node("CanvasLayer").add_child(b)
	get_tree().paused = true
	
	
	#Engine.time_scale = 0.1
	#while(timer2.time_left!=0):
	#	print(timer2.time_left)
	#	global_position.x = global_position.x + randi()%2-0.5
	#	global_position.y = global_position.y + randi()%2-0.5
	#print(get_node("Sprite"))
	#get_tree().reload_current_scene()