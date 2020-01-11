extends KinematicBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	add_child(timer) #to process
	timer.start(2) #to start


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_timer_timeout():
   queue_free()