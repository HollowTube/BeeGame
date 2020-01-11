extends Node2D

var armed = false
var hit = false
var ready = false;

var x_ini
var y_ini
var x_towards
var y_towards

var velocity = 800
var c
var x_vel
var y_vel

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.start(1) #to start
	x_towards = rand_range(50, 462)
	y_towards = rand_range(50, 250)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if ready:
		global_position.x = global_position.x + x_vel*delta
		global_position.y = global_position.y + y_vel*delta

func _on_timer_timeout():
	if !hit:
		armed = true
		hit = true
		$Sprite.modulate = Color(1, 0, 1)
		timer.start(0.5)
	else:
		queue_free()

func _on_Area2D_body_entered(body):
	if armed == true and (body.get_name() == "Player" or body.get_name() == "Player2"):
		body.die()