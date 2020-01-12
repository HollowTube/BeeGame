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
		var zoom = clamp(smoothZoom, 0.5, 2.0)
		posX = clamp(lerp(posX,target_x, 10 * delta),0,512)
		posY = clamp(lerp(posY,target_y, 10 * delta),0,300)
		self.zoom = Vector2(smoothZoom,smoothZoom)
		self.position = Vector2(posX,posY)
	
	elif shaking:
		var y = rand_range(-7,7)
		set_offset(Vector2(0,y))
	
func _timeout():
	zooming = false
	if shaking:
		shaking = false
		set_offset(Vector2(0,0))
		
	
func zoomIn(pos):
	
	timer.start(0.5)
	target_x = pos.x
	target_y = pos.y
	zooming = true;
	
func shake(time):
	timer.start(time)
	shaking = true
	
func reset():
	self.position = Vector2(default_x,default_y)
