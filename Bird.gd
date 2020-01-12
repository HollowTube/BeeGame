extends Node2D

var armed = false


var speed = 3
var rotation_speed = 4
var rotation_dir = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	add_child(timer) #to process
	timer.start(0.05) #to start

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var velocity = Vector2()
	velocity = Vector2(speed, 0).rotated(rotation)
	rotation += rotation_dir * rotation_speed * delta
	global_position += velocity

func _on_timer_timeout():
   armed = true

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		body.die()
	if armed == true and body.get_name() == "Player2":
		body.die()


func _on_VisibilaityNotifier2D_screen_exited():
	get_owner().birddead = true
	queue_free()
