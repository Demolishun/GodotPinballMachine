extends Spatial

const ball_scene = preload("res://moving_objects/Ball.tscn")
#const base = get_node(@"/root/Root/Base")
#const main_scene = main_scene = get_node(@"/root/Root")
var dont_spawn = false
const ball_spawn_vect = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("_ready")
	# connect to controls signal
	$DeveloperPanel/SpawnBall.connect("spawn_ball", self, "spawn_ball")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func spawn_ball():
	if !dont_spawn:
		print("spawn_ball")
		#var base = get_node(@"/root/Root/Base")
		var main_scene = get_node(@"/root/Root")	
		var ball = ball_scene.instance()
		var ball_spawner = $Base/Plunger/Arm/BallSpawner/CollisionShape
		#print(ball_spawner.translation)
		#print(ball_spawner.transform)		
		#print(ball_spawner.global_transform.origin)
		#for i in ball_spawner.get_property_list():
		#	print(i.name)		
		#for i in ball_spawner.transform:
		#	print(i)
		#print(base.translation)
		#ball.set_translation( base.translation+ball_spawn_vect)
		ball.set_translation(ball_spawner.global_transform.origin+ball_spawn_vect)
		main_scene.add_child(ball)
