extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var clicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_on_click")
	pass
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if (get_name() == "vn1"):
			var b = load("res://vn1part2.tscn").instance()
			get_parent().get_parent().add_child(b)
			get_parent().queue_free()
		elif (get_name() == "vn1part2"):
			var b = load("res://hazards.tscn").instance()
			get_parent().get_parent().get_parent().get_node("World/Player").start = true
			get_parent().get_parent().get_parent().get_node("World/Player2").start = true
			get_parent().get_parent().get_parent().get_node("World").add_child(b)
			get_parent().queue_free()
			
		elif (get_name() == "vn2"):
			get_tree().paused= false
			get_tree().reload_current_scene()
		

