extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Laser = preload("res://Laser.tscn")
var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer) #to process
	timer.start(6) #to start

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_laser():
	var l = Laser.instance()
	get_parent().add_child(l)
	var side = randi()%4
	match side:
		0:
			l.x_ini = rand_range(0, 512)
			l.y_ini = 0
		1:
			l.x_ini = 512
			l.y_ini = rand_range(0, 300)
		2:
			l.x_ini = rand_range(0, 512)
			l.y_ini = 300
		3:
			l.x_ini = 0
			l.y_ini = rand_range(0, 300)
		_:
			l.x_ini = 0
			l.y_ini = 0
	l.position.x = l.x_ini
	l.position.y = l.y_ini
	l.c = sqrt(pow(l.x_ini-l.x_towards, 2) + pow(l.y_ini - l.y_towards, 2))
	l.x_vel = (l.x_towards - l.x_ini)/(l.c/l.velocity)
	l.y_vel = (l.y_towards - l.y_ini)/(l.c/l.velocity)
	l.ready = true
	
func _on_timer_timeout():
	spawn_laser()
	timer.start(6)