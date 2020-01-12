extends Node2D

var armed = false
var player_number = 0
var direction = "left"

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
	if direction =="left":
		global_position.x = global_position.x - 350*delta
		
	if direction == "right":
		global_position.x = global_position.x + 350*delta
		$Sprite.set_flip_h(true)


func _on_timer_timeout():
   armed = true

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player2":
		body.die()
	if armed == true and body.get_name() == "Player":
		body.die()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
