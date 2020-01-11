extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var default_x = 256
var default_y = 150

var zooming = false;
var shaking = false;
var timer = Timer.new()

var smoothZoom = 1
var target_x
var target_y
var posX = default_x
var posY = default_y

# Called when the node enters the scene tree for the first time.
func _ready():
	posX = default_x
	posY = default_y
	timer.connect("timeout",self,"_timeout")
	add_child(timer)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if zooming:
		smoothZoom = lerp(smoothZoom,0.2, 5* delta)
		posX = lerp(posX,target_x, 10 * delta)
		posY = lerp(posY,target_y, 10 * delta)
		self.zoom = Vector2(smoothZoom,smoothZoom)
		self.position = Vector2(posX,posY)
	
	elif shaking:
		var y = default_y + randi()%70-35
		self.position = Vector2(default_x,y)
	
func _timeout():
	zooming = false
	if shaking:
		shaking = false
		print("stop shaking")
		
	
func zoomIn(pos):
	
	timer.start(0.5)
	target_x = pos.x
	target_y = pos.y
	zooming = true;
	
func shake():
	timer.start(0.1)
	shaking = true
	
func reset():
	self.position = Vector2(default_x,default_y)