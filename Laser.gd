extends Node2D

var flower0 = preload("res://assets/flower1.png")
var flower1 = preload("res://assets/flower2.png")
var flower2 = preload("res://assets/flower3.png")
var flower3 = preload("res://assets/flower4.png")

var armed = false
var hit = false
var ready = false;

var x_vel
var y_vel

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.start(1.5) #to start
	
	var flower = randi()%4
	match flower:
		0: $Sprite.texture = flower0
		1: $Sprite.texture = flower1
		2: $Sprite.texture = flower2
		3: $Sprite.texture = flower3

	var scale = rand_range(1,5)
	
	self.set_scale(Vector2(scale, scale))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if ready:
		global_position.x = global_position.x + x_vel*delta
		global_position.y = global_position.y + y_vel*delta

func _on_timer_timeout():
	queue_free()

func _on_Area2D_body_entered(body):
	if armed == true and (body.get_name() == "Player" or body.get_name() == "Player2"):
		body.die()