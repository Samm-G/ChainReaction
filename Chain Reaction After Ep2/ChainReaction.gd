extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal splitter_complete

var upb = 0
var downb = 6
var leftb = 0
var rightb = 10

var spatial_button = preload("res://SpatialButton.tscn")

var cur_button = null

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	add_buttons()
	
	pass
	
func add_buttons():

	for i in range(leftb,rightb):
		for j in range(upb,downb):
			var sb = spatial_button.instance()
			$SpatialButtons.add_child(sb)
			sb.translation = Vector3(j+0.5,1,i+0.5)
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	print(cur_button)
	
	pass