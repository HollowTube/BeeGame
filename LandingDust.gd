extends Node2D

var cat = "normal"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if cat == "explosion":
		$Sprite.texture = load("res://assets/explosion.png")
		scale = Vector2(2,2)
		global_position.y = global_position.y - 15
	if cat == "explosionbird":
		$Sprite.texture = load("res://assets/explosionbird.png")
		scale = Vector2(2,2)
		global_position.y = global_position.y - 15
	
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	add_child(timer) #to process
	timer.start(1) #to start
	$AnimationPlayer.play("land")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_timer_timeout():
   queue_free()

