extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $menu/buttons.get_children():
		if (button.get_name() != "quitbtn"):
			button.connect("pressed", self, "_on_button_pressed", [button.scene_to_load])
		else:
			button.connect("pressed", self, "_on_quit_pressed")
	
func _on_button_pressed(scene_to_load):
	load(scene_to_load)
	get_tree().change_scene(scene_to_load)
	
func _on_quit_pressed():
	get_tree().quit()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		load("res://Game.tscn")
		get_tree().change_scene("res://Game.tscn")
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		