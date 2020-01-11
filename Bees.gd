extends Node2D

var armed = false
var player_number = 0

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

func _physics_process(delta):
	global_position.x = global_position.x + randi()%2-0.5
	global_position.y = global_position.y + randi()%2-0.5


func _on_timer_timeout():
   queue_free()

func _on_ArmArea_body_exited(body):
	if body.get_name() == "Player" or body.get_name() == "Player2":
		armed = true
		if player_number == 1:
			$Sprite.modulate = Color(1, 0, 0) # red
		if player_number == 2:
			$Sprite.modulate = Color(0, 1, 0) # green


func _on_Area2D_body_entered(body):
	if armed == true and (body.get_name() == "Player" or body.get_name() == "Player2"):
		body.die()
