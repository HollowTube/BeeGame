extends Line2D

var velocity = Vector2()
var grav = 10
# Called when the node enters the scene tree for the first time.

func _ready():
	print("Spawned")

func _physics_process(delta):
	var pos = Vector2(0,0)
	var num_points = 30 # how many points you want to show
	
	for i in range(num_points):
		set_point_position(i, pos -position)
		velocity.y = velocity.y + grav
		pos += velocity *delta