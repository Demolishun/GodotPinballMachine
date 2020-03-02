extends Button

#const ball_scene = preload("res://moving_objects/Ball.tscn")
#const game_script = preload("res://game_scene_main.gd")
signal spawn_ball()

func _on_Button_pressed():
	print("signal:spawn_ball")
	emit_signal("spawn_ball")
#	print("Spawn Ball")	
#	#var main_scene = get_tree().current_scene	
#	var base = get_node(@"/root/Root/Base")
#	var main_scene = get_node(@"/root/Root")	
#	var ball = ball_scene.instance()
#	print(base.translation)
#	ball.set_translation( base.translation+Vector3(0,1,0))
#	main_scene.add_child(ball)
	
	
