extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Color) var backboardcolor setget setbbcolor, getbbcolor

var bbmaterial

func setbackboardcolor(color):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	bbmaterial = $Back.get_surface_material(0)
	#bbmaterial.set_albedo(backboardcolor)
	backboardcolor = Color(1.0,1.0,1.0)

func setbbcolor(color):	
	if bbmaterial:
		bbmaterial.set_albedo(color)

func getbbcolor():
	if bbmaterial:
		return bbmaterial.get_albedo()
	return Color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
