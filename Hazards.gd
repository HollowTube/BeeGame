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
	l.position.x = rand_range(0, 512)
	l.position.y = rand_range(0, 300)
	
func _on_timer_timeout():
	spawn_laser()
	timer.start(6)

func _physics_process(delta):
	
	pass