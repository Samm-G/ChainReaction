extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass





func _on_RigidBody_mouse_entered():
	get_node("../..").cur_button = Vector2(translation.z-0.5,translation.x-0.5)
	pass # replace with function body


func _on_RigidBody_mouse_exited():
	get_node("../..").cur_button = null
	pass # replace with function body
