extends Spatial

const ball_scene = preload("res://moving_objects/Ball.tscn")
#const base = get_node(@"/root/Root/Base")
#const main_scene = main_scene = get_node(@"/root/Root")
var dont_spawn = false
const ball_spawn_vect = Vector3(0,0,0)
const timer_max_time = 3.0
var launch_force = 0.0
const max_launch_force = 1000
const launch_vec = Vector3(0,0,-1)
var start_vec 
var start_grav

# Called when the node enters the scene tree for the first time.
func _ready():
	print("_ready")
	
	$AnimationPlayer.play("PlungerAnimPull", -1, -20.0, false)
	start_vec = $Base/Plunger/Arm/BallSpawner.gravity_vec
	start_grav = $Base/Plunger/Arm/BallSpawner.gravity
	
	# connect to controls signal
	$DeveloperPanel/SpawnBall.connect("spawn_ball", self, "spawn_ball")
	$Launch/Button.connect("button_down", self, "launch_pull")
	$Launch/Button.connect("button_up", self, "launch_release")
	$AnimationPlayer.connect("animation_finished", self, "animation_finished")
	#$Base/Plunger/Arm/BallSpawner.connect("body_exited", self, "body_exited")
	$Base/Plunger/Arm/StaticBody.connect("input_event", self, "arm_clicked")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func spawn_ball():
	if !dont_spawn:
		print("spawn_ball")
		#var base = get_node(@"/root/Root/Base")
		var main_scene = get_node(@"/root/Root")	
		var ball = ball_scene.instance()
		ball.name = "ball"
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
		
func launch_pull():
	print("launch_pull")
	$LaunchTimer.start(timer_max_time)
	$AnimationPlayer.play("PlungerAnimPull")
	launch_force = 0.0
	
func launch_release():
	print("launch_release")	
	print($LaunchTimer.time_left)
	print($LaunchTimer.wait_time)
	$LaunchTimer.stop()
	#$AnimationPlayer.stop()
	#$AnimationPlayer.play("PlungerAnimRelease")
	launch_force = $AnimationPlayer.current_animation_position / $AnimationPlayer.current_animation_length	
	$AnimationPlayer.play("PlungerAnimPull", -1, -20.0, true) #  needs true at end register play events
	
func animation_finished(anim_name):
	if anim_name == "PlungerAnimPull":
		if launch_force > 0.0:
			print("launch_ball: ", launch_force)
			#print($Base/Plunger/Arm/BallSpawner.gravity_vec)
			#$Base/Plunger/Arm/BallSpawner.gravity_vec = launch_vec
			#$Base/Plunger/Arm/BallSpawner.gravity = launch_force*max_launch_force
			#call_deferred("reset_launch")
			for node in $Base/Plunger/Arm/BallSpawner.get_overlapping_bodies():
				print(node.name)	
				node.apply_impulse(Vector3(0,0,0), Vector3(0,0,-1*launch_force*max_launch_force))
			
			
func reset_launch():
	print("reset_launch")
	#$Base/Plunger/Arm/BallSpawner.gravity_vec = start_vec
	#$Base/Plunger/Arm/BallSpawner.gravity = start_grav
	
func body_exited(node):
	print("body_exited: ", node.name)
	if node.name == "ball":
		reset_launch()
		
func arm_clicked(camera, event, click_pos, click_norm, objid):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				#print("arm clicked")
				launch_pull()
			else:
				#print("arm unclicked")
				launch_release()


