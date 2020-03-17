extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var level_path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	if level_path != "":
		print("load scene:", level_path)
		var res = load(level_path)
		get_tree().change_scene_to(res)
		
		#var err = get_tree().change_scene(level_path)
		#if err:
		#	print("error loading:", level_path, " ", err)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
