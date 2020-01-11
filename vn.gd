extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_on_click")
	pass
	
func _on_click():
	if (self.get_name() == "vn1"):
		get_tree().change_scene("res://World.tscn")
	elif (self.get_name() == "vn2"):
		get_tree().change_scene("res://game_over.tscn")
		

