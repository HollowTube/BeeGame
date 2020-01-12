extends KinematicBody2D


var Bird = preload("res://Bird.tscn")
var Bees = preload("res://Bees.tscn")
var Bullet = preload("res://Bullet.tscn")
var LandingDust = preload("res://LandingDust.tscn")

var air = false

var timer = Timer.new()
var timer2 = Timer.new()

var guide_timer = 0

var deathPosX
var deathPosY

export var player_number = 1

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
var player;
var bgPlayer;

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

	player = AudioStreamPlayer.new()
	bgPlayer = AudioStreamPlayer.new()
	

	
	add_child(player)
	add_child(bgPlayer)
	
	bgPlayer.stream = load("res://FlightOfTheBumbleBees.wav")
	bgPlayer.volume_db = -8
	bgPlayer.play()
	
	timer.connect("timeout",self,"_on_timer_timeout")
	timer2.connect("timeout",self,"_timeout")
	add_child(timer) #to process
	add_child(timer2)
	timer.start(0.05) #to start


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
	
		if air == true:
			#player.stream = load("res://grassy2.wav")
			#player.play()
			spawn_dust()
	
		air = false
	
		if dashing == true:
			dash_timer = 0
			post_dashing = true
			spawn_bullet()
			
			get_node("../Camera2D").shake()
			
			player.stream = load("res://explosion1.wav")
			player.volume_db = -10
			player.play()
			
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
						bird.global_position = global_position
						get_parent().add_child(bird)
						
						post_guiding = true
				elif post_guiding == true:
					$AnimationPlayer.play("slam_fall")
					motion.x = 0
					if is_instance_valid(bird):
						if Input.is_action_pressed(RIGHT):
							bird.rotation_dir = 1
						elif Input.is_action_pressed(LEFT):
							bird.rotation_dir = -1
						else:
							bird.rotation_dir = 0
			else:
				if guiding == true:
					guide_timer =0
					guiding = false
					post_guiding = false
					if is_instance_valid(bird):
						bird.rotation_dir = 0
		floor_timer = 0;
	
	floor_timer += delta
	
	if floor_timer < 0.1:
	
			
		if Input.is_action_pressed(UP):
			player.stream = load("res://grassy1.wav")
			player.play(0.015)
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
	spawn_bee()
	timer.start(0.05)
	
func _timeout():
	dead = false
	get_tree().paused= false
	get_tree().reload_current_scene()
	
func die():
	timer2.start(1.5)
	player.stream = load("res://Busted.wav")
	
	player.play()
	deathPosX = global_position.x
	deathPosY = global_position.y
	get_node("../Camera2D").zoomIn(global_position)
	get_tree().paused = true
	dead = true
	
	#Engine.time_scale = 0.1
	#while(timer2.time_left!=0):
	#	print(timer2.time_left)
	#	global_position.x = global_position.x + randi()%2-0.5
	#	global_position.y = global_position.y + randi()%2-0.5
	#print(get_node("Sprite"))
	#get_tree().reload_current_scene()