extends Spatial

const ball_scene = preload("res://moving_objects/Ball.tscn")
const balltrans_scene = preload("res://moving_objects/BallTrans.tscn")
#const base = get_node(@"/root/Root/Base")
#const main_scene = main_scene = get_node(@"/root/Root")
var dont_spawn = false
const ball_spawn_vect = Vector3(0,0,0)
const timer_max_time = 3.0
var launch_force = 0.0
const max_launch_force = 10000
const launch_vec = Vector3(0,0,-1)
var start_vec 
var start_grav
var launch_state = false
var ballfeed_state = false
var lpaddle_state = false
var rpaddle_state = false

export var flinger_force = 2000

func isBall(node):
	if node.get_parent() == $Balls:
		return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("_ready")
	
	# make it random
	randomize()
	
	$AnimationPlayer.play("PlungerAnimPull", -1, -20.0, false)
	start_vec = $Base/Plunger/Arm/BallSpawner.gravity_vec
	start_grav = $Base/Plunger/Arm/BallSpawner.gravity
	
	# connect to controls signal
	$DeveloperPanel/SpawnBall.connect("spawn_ball", self, "spawn_ball")
	#$Launch/Button.connect("button_down", self, "launch_pull")
	#$Launch/Button.connect("button_up", self, "launch_release")
	$AnimationPlayer.connect("animation_finished", self, "animation_finished")
	#$Base/Plunger/Arm/BallSpawner.connect("body_exited", self, "body_exited")
	$Base/Plunger/Arm/StaticBody.connect("input_event", self, "arm_clicked")
	$Base/Plunger/Arm/StaticBody.connect("mouse_exited", self, "launch_release")
	$Base/FeedButton/StaticBody.connect("input_event", self, "ballfeed_clicked")
	$Base/FeedButton/StaticBody.connect("mouse_exited", self, "ballfeed_mouseleave")
	$BallEater.connect("body_entered", self, "ball_entered_eater")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# ball feed button
	if Input.is_action_just_pressed("ui_accept"):
		ballfeed_down()
	elif Input.is_action_just_released("ui_accept"):
		ballfeed_up()
	# launch
	if Input.is_action_just_pressed("ui_select"):
		launch_pull()
	elif Input.is_action_just_released("ui_select"):
		launch_release()
	# paddles
	if Input.is_action_just_pressed("ui_left"):
		lpaddle_press()
	elif Input.is_action_just_released("ui_left"):
		lpaddle_unpress()
	if Input.is_action_just_pressed("ui_right"):
		rpaddle_press()
	elif Input.is_action_just_released("ui_right"):
		rpaddle_unpress()
		
	if Input.is_action_just_pressed("ui_cancel"):
		var res = load("res://controls/MainMenu.tscn")
		get_tree().change_scene_to(res)
	
func lpaddle_press():
	lpaddle_state = true
	$AnimationPlayerLeft.play("LeftPaddle", -1, 5.0, true)
	
func lpaddle_unpress():
	if lpaddle_state:
		$AnimationPlayerLeft.play("LeftPaddle", -1, -5.0, true)
		lpaddle_state = false
		
func rpaddle_press():
	rpaddle_state = true
	$AnimationPlayerRight.play("RightPaddle", -1, 5.0, true)
	
func rpaddle_unpress():
	if rpaddle_state:
		$AnimationPlayerRight.play("RightPaddle", -1, -5.0, true)
		rpaddle_state = false
	
func spawn_ball():	
	if !dont_spawn && !$Balls.get_child_count():
		print("spawn_ball")
		#var base = get_node(@"/root/Root/Base")
		var main_scene = get_node(@"/root/Root")
		var ball
		if randi() % 4 == 0:
			ball = balltrans_scene.instance()	
		else:
			ball = ball_scene.instance()		
		ball.name = "ball"
		$Balls.add_child(ball)
		var ball_spawner = $Base/Plunger/Arm/BallSpawner/CollisionShape		
		ball.set_translation(ball_spawner.global_transform.origin+ball_spawn_vect)		
		
func launch_pull():
	print("launch_pull")
	launch_state = true
	#$LaunchTimer.start(timer_max_time)
	$AnimationPlayer.play("PlungerAnimPull")
	launch_force = 0.0
	
func launch_release():
	print("launch_release")	
	if launch_state:
		launch_force = $AnimationPlayer.current_animation_position / $AnimationPlayer.current_animation_length	
		$AnimationPlayer.play("PlungerAnimPull", -1, -20.0, true) #  needs true at end register play events
		launch_state = false
	
func animation_finished(anim_name):
	if anim_name == "PlungerAnimPull":
		if launch_force > 0.0:
			print("launch_ball: ", launch_force)			
			for node in $Base/Plunger/Arm/BallSpawner.get_overlapping_bodies():
				if isBall(node):
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
				
func ballfeed_clicked(camera, event, click_pos, click_norm, objid):	
	if event is InputEventMouseButton:				
		if event.button_index == BUTTON_LEFT:		
			if event.pressed:
				#print("feed clicked")				
				ballfeed_down()				
			else:
				#print("feed unclicked")
				if ballfeed_state:
					ballfeed_up()					
				
func ballfeed_mouseleave():
	if ballfeed_state:
		ballfeed_up()		
				
func ballfeed_down():
	ballfeed_state = true
	$AnimationPlayer.play("BallFeedPush", -1, 5.0, true)
func ballfeed_up():
	ballfeed_state = false
	$AnimationPlayer.play("BallFeedPush", -1, -5.0, true)
	spawn_ball()
	
				
func ball_entered_eater(node):
	print(node.name)
	if isBall(node):
		node.queue_free()
		$APBackBoard1.play("RedFlash",-1,2.0,false)


