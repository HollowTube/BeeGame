extends KinematicBody2D

class_name Player

var motion = Vector2()
var state: Object

var trail_timer = Timer.new()
var trail_scene = preload("res://characters/Trail.tscn")
var trail_counter = 0

var facing = 1

var SPAWN_RATE = 0.1

slave func setState(pos, mot, sta):
	position = pos
	motion = mot
	if state.name != sta:
		change_to(sta)
  
master func shutItDown():
	#Send a shutdown command to all connected clients, including this one
	rpc("shutDown")
  
sync func shutDown():
	get_tree().quit()
  
func _ready():
	trail_timer.connect("timeout",self,"_on_trail_timer_timeout")
	add_child(trail_timer) #to process
	trail_timer.start(0.05) #to start

	change_to("OnFloor")

func change_to(new_state):
		state = get_node("StateMachine/" + new_state)
		_enter_state()


func _enter_state():
	state.player = self
	state.enter()

func _physics_process(delta):

	if state.has_method("physics_process"):
		state.physics_process(delta)

	if(is_network_master()):
      
		# Tell the other computer about our new state so it can update 
		# State includes position, motion and facing
		# Eventually include all game states?       
		rpc_unreliable("setState",Vector2(position.x, position.y), motion, state.name)   


	if motion.x > 0:
		facing = 1
		get_node("Sprite").set_flip_h(true)
	elif motion.x < 0:
		facing = -1
		get_node("Sprite").set_flip_h(false)

	# Move our local player
	motion = move_and_slide(motion, Vector2(0, -1))

func _on_trail_timer_timeout():
	var busy = false

	for trail in get_node("Trails").get_children():
		if trail.overlaps_area(get_node("TrailSpawnArea")):
			busy = true
	if not busy:
		spawn_trail()
	trail_timer.start(SPAWN_RATE)

func spawn_trail():
	var trail = trail_scene.instance()
	trail.player = self
	get_node("Trails").add_child(trail)
	trail_counter += 1

func set_player_name(new_name):
	get_node("Label").set_text(new_name)
	
func die():
	if(is_network_master()):
		queue_free()