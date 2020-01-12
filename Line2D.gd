extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var point 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	point = get_parent().get_node("Bird").global_position
	print(point)
	add_point(point)
	pass

