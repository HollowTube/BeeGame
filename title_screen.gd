extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $menu/center_row/buttons3.get_children():
		if (button.get_name() != "quitbtn"):
			button.connect("pressed", self, "_on_button_pressed", [button.scene_to_load])
		else:
			button.connect("pressed", self, "_on_quit_pressed")
	
func _on_button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)
	
func _on_quit_pressed():
	get_tree().quit()
	
	