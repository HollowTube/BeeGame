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

var Laser = preload("res://Laser.tscn")

var timer = Timer.new()
var laserunits = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.start(0.85) #to start
	laserunits.connect("timeout",self,"_on_laserunits_timeout") 
	add_child(laserunits) #to process
	laserunits.start(0.05) #to start
	
	x_towards = rand_range(80, 432)
	y_towards = rand_range(80, 220)

func _physics_process(delta):
	pass

func _on_timer_timeout():
	if !hit:
		armed = true
		hit = true
		$Sprite.modulate = Color(1, 0, 1)
		timer.start(1)
	else:
		queue_free()
	
func spawn_laserunits():
	var l = Laser.instance()
	get_parent().add_child(l)
	if armed:
		l.armed = true
	l.position.x = x_ini + rand_range(-40, 40)
	l.position.y = y_ini + rand_range(-40, 40)
	l.x_vel = x_vel
	l.y_vel = y_vel
	l.ready = ready

func _on_laserunits_timeout():
	spawn_laserunits()
	laserunits.start(0.01)