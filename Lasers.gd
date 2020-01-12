extends Node2D

var armed = false
var warning = true
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
	timer.start(1.5) #warning duration
	laserunits.connect("timeout",self,"_on_laserunits_timeout") 
	add_child(laserunits) #to process
	
	x_towards = rand_range(80, 432)
	y_towards = rand_range(80, 220)
	$AnimationPlayer.play("warning")

func _physics_process(delta):
	if armed && $Sprite.modulate.a > 0:
		$Sprite.modulate.a -= 0.1

func _on_timer_timeout():
	if warning:
		armed = true
		warning = false
		timer.start(1.25) #shooting duration
		get_parent().get_node("Camera2D").shake(1.25)
		laserunits.start(0.02)
	else:
		queue_free()
	
func spawn_laserunits():
	var l = Laser.instance()
	get_parent().add_child(l)
	if armed:
		l.armed = true
	l.position.x = x_ini + rand_range(-30, 30)
	l.position.y = y_ini + rand_range(-30, 30)
	l.x_vel = x_vel
	l.y_vel = y_vel
	l.ready = ready

func _on_laserunits_timeout():
	spawn_laserunits()
	laserunits.start(0.02)