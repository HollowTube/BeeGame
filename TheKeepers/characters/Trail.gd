extends Area2D

var player : Object
var count = 0
var armed = false
var death_timer = Timer.new()
var rng = RandomNumberGenerator.new()


func _ready():
	position = player.position
	count = player.trail_counter
	death_timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(death_timer)
	death_timer.start(2)
	rng.seed = 0

func _physics_process(delta):
	if player.trail_counter > count + 3:
		armed = true
		modulate = Color(1,0,0)

func _on_timer_timeout():
	queue_free()

func _on_Trail_body_entered(body):
	if armed and body.has_method("die"):
		body.change_to("Dead")
