extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ballrotation = 0

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
	#apply_torque_impulse(Vector3(0,5000,0)) # nope
	#var dotprod = Vector3.dot(state.linear_velocity)
	var speed = state.linear_velocity.length()
	var dir = state.linear_velocity.normalized()
	var dir90 = dir.rotated(Vector3(0,1,0),deg2rad(90))
	#print(dir,dir90)
	var delta = state.step
	ballrotation += speed*delta
	#$MeshInstance.transform.rotated(dir90, ballrotation) # nope
	#state.angular_velocity.rotated(dir90, ballrotation) # nope
	#apply_torque_impulse(dir90*speed) # nope
