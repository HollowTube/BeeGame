extends Node

var file_path = "res://dialogue/text_end_bird.txt"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var rand_line = get_line_from_file(file_path)
	print(rand_line)
	$text.text = rand_line
	
	for button in get_children():
		if "TextureButton" in button.get_name():
			if (button.get_name() != "quitbtn"):
				button.connect("pressed", self, "_on_button_pressed", [button.scene_to_load])
			else:
				button.connect("pressed", self, "_on_quit_pressed")

	
func load_file(file_path):
	var file = File.new()
	file.open(file_path, file.READ)
	var text = file.get_as_text()
	return text
	
func get_line_from_file(file_path):
	var text = load_file(file_path).strip_edges()
	var lines = text.split(";")
	print(lines)
	randomize()
	return lines[randi()%lines.size()]
	
#func display_text(text):

	
func _on_button_pressed(scene_to_load):
	
	get_tree().paused= false
	get_tree().change_scene(scene_to_load)

	
func _on_quit_pressed():
	get_tree().quit()


