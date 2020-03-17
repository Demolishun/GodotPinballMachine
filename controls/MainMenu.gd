extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var levels = Array()
var levels_path = "res://levels"
const level_button = preload("res://controls/LevelButton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	var dir = Directory.new()
	if dir.open(levels_path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var width = 50
		var height = 25
		var count = 0
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				print("Found file: " + file_name)
				var file = File.new()
				if file_name.ends_with(".tscn"):
					var button = level_button.instance()
					button.text = filename
					button.rect_position = Vector2(0,count*height)
					button.rect_size = Vector2(width,height)
					button.level_path = levels_path + "/" + file_name
					$LevelButtons.add_child(button)
			file_name = dir.get_next()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
