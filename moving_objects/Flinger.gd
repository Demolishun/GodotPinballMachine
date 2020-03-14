extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var anim_speed = 5.0
export var impulse_force = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Flinger_body_entered(node):
	pass # Replace with function body.
	print("collision with:",node.name)
	if node is RigidBody and node.mode == RigidBody.MODE_RIGID:
		print("fling!")
		$AnimationPlayer.play("Fling", -1, anim_speed)
		var dir = transform.origin.direction_to(node.transform.origin)
		node.apply_central_impulse(dir*impulse_force)
