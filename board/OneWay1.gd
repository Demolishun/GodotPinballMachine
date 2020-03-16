extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var node_group = ""
export(Vector3) var force_dir = Vector3(0,0,1)
export(float) var force_fudge = 1.0

var ng

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	ng = get_node(node_group)
	print(ng, node_group)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_OneWay_body_entered(body):	
	if ng and body.get_parent() == ng:
		if 0:
			print("OneWay:", body.name)
			var lv = Vector3(body.linear_velocity)
			var speed = lv.length()
			var gtrans = global_transform.basis.xform(force_dir)
			body.linear_velocity = gtrans*speed*force_fudge			
		else:
			print("other one way:", body.name)
			var body_dir = body.linear_velocity.normalized()
			var owdir = global_transform.basis.xform(force_dir).normalized()
			#var owdir = transform.basis.z # huh?
			if owdir.dot(body_dir) < 0:
				body.linear_velocity = body.linear_velocity.bounce(owdir)
			
		
