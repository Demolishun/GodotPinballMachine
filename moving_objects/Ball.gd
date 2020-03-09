extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	pass

func _integrate_forces(state):
	pass
	#print(state.linear_velocity)
	#print(state.angular_velocity)
	#state.linear_velocity
	#state.linear_velocity = Vector3()
	#state.angular_velocity = Vector3(0,5,0)
