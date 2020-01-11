extends Node2D

var armed = false
var hit = false

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.start(1.5) #to start
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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