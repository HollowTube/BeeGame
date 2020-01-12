extends Node

export(String) var file_path

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand_line = get_line_from_file(file_path)
	if ("end" in file_path):
		$text.text = rand_line
	else:
		var lines = rand_line.split(":")
		var line1 = lines[0]
		var line2 = lines[1]
		$text.text = line1
		$"/root/global".response = line2
#	display_text(text)
	
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

	






