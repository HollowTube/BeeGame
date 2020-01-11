extends Node2D

var armed = false
var player_number = 0
var fading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	add_child(timer) #to process
	timer.start(1.9) #to start
	
	if randi()%2 == 0:
		$Sprite.set_flip_h(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	global_position.x = global_position.x + randi()%2-0.5
	global_position.y = global_position.y + randi()%2-0.5
	
	if fading == true:
		$Sprite.modulate.a -= 0.1
	
	if $Sprite.modulate.a <0:
		queue_free()
		


func _on_timer_timeout():
   fading = true

func _on_ArmArea_body_exited(body):
	if body.get_name() == "Player" or body.get_name() == "Player2":
		
		if player_number == body.player_number:
			armed = true


func _on_Area2D_body_entered(body):
	if armed == true and (body.get_name() == "Player" or body.get_name() == "Player2"):
		body.die()
