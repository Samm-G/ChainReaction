extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar" 

var upb = 0
var downb = 6
var leftb = 0
var rightb = 10

var spatial_button = preload("res://SpatialButton.tscn")

var cur_button = null

var single_sph = preload("res://SingleSphere.tscn")
var two_sph = preload("res://TwoSpheres.tscn")
var three_sph = preload("res://ThreeSpheres.tscn")
var four_sph = preload("res://FourSpheres.tscn")

class Space:
	var n = 0
	var col = -1	# 0 for pl1, 1 for pl2, 2 for pl3 and so on...

#Data Layer
var board_data = []

#Visual Spheres Layer..
var board_spheres = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	add_buttons()
	
	#Populate the board_data array..
	for i in range(leftb,rightb):
		var b_arr = []
		for j in range(upb,downb):
			b_arr.append(Space.new())
		board_data.append(b_arr)
		
	#Populate the board_spheres array..
	for i in range(leftb,rightb):
		var s_arr = []
		for j in range(upb,downb):
			var s = single_sph.instance()
			$Spheres.add_child(s)
			
			s.translation = Vector3(j+0.5,0.5,i+0.5)
			s_arr.append(s)
			s.hide()
		board_spheres.append(s_arr)
	
	print_board_data()
	
	pass
	
func print_board_data():
	
	for i in board_data:
		print("(")
		for j in i:
			print("(",j.n)
			print(j.col,")")
		print(")")
		
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
	
	if Input.is_action_just_released("ui_click"):
		if cur_button != null:
			
			button_pressed(cur_button)
			
			pass
	
	#print(cur_button)
	
	pass
	
func button_pressed(pos):
	
	board_data[pos.x][pos.y].n += 1
	
	explode(pos)
	
	print_board_data()
	
	pass

func explode(pos):
	
	#Corners...
	if (pos.x == leftb or pos.x == rightb-1) and (pos.y == upb or pos.y == downb-1) and board_data[pos.x][pos.y].n >= 2:
		
		board_data[pos.x][pos.y].n -= 2
		
		if pos.x == leftb and pos.y == upb:
			board_data[pos.x+1][pos.y].n +=1
			board_data[pos.x][pos.y+1].n +=1
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x,pos.y+1))
		elif pos.x == leftb and pos.y == downb-1:
			board_data[pos.x+1][pos.y].n +=1
			board_data[pos.x][pos.y-1].n +=1
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
		elif pos.x == rightb-1 and pos.y == upb:
			board_data[pos.x-1][pos.y].n +=1
			board_data[pos.x][pos.y+1].n +=1
			explode(Vector2(pos.x-1,pos.y))
			explode(Vector2(pos.x,pos.y+1))
		elif pos.x == rightb-1 and pos.y == downb-1:
			board_data[pos.x-1][pos.y].n +=1
			board_data[pos.x][pos.y-1].n +=1
			explode(Vector2(pos.x-1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
			
		#Replace the visuals of the sphere to the current board_data values..
		replace_sphere(pos,board_data[pos.x][pos.y].n)
		return
		
	#Edges..
	if (pos.x == leftb or pos.x == rightb-1 or pos.y == upb or pos.y == downb-1) and board_data[pos.x][pos.y].n >= 3:
			
		board_data[pos.x][pos.y].n -= 3
		
		if pos.x == leftb:
			board_data[pos.x][pos.y+1].n +=1
			board_data[pos.x+1][pos.y].n +=1
			board_data[pos.x][pos.y-1].n +=1
			explode(Vector2(pos.x,pos.y+1))
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
		elif pos.x == rightb-1:
			board_data[pos.x][pos.y+1].n +=1
			board_data[pos.x-1][pos.y].n +=1
			board_data[pos.x][pos.y-1].n +=1
			explode(Vector2(pos.x,pos.y+1))
			explode(Vector2(pos.x-1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
		elif pos.y == upb:
			board_data[pos.x+1][pos.y].n +=1
			board_data[pos.x][pos.y+1].n +=1
			board_data[pos.x-1][pos.y].n +=1
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x,pos.y+1))
			explode(Vector2(pos.x-1,pos.y))
		elif pos.y == downb-1:
			board_data[pos.x+1][pos.y].n +=1
			board_data[pos.x][pos.y-1].n +=1
			board_data[pos.x-1][pos.y].n +=1
			explode(Vector2(pos.x+1,pos.y))
			explode(Vector2(pos.x,pos.y-1))
			explode(Vector2(pos.x-1,pos.y))
			
		#Replace the visuals of the sphere to the current board_data values..
		replace_sphere(pos,board_data[pos.x][pos.y].n)
		return
		
	#Spaces in the middle..
	
	if board_data[pos.x][pos.y].n >= 4: 
			
		board_data[pos.x][pos.y].n -= 4
		
		board_data[pos.x][pos.y+1].n +=1
		board_data[pos.x+1][pos.y].n +=1
		board_data[pos.x][pos.y-1].n +=1
		board_data[pos.x-1][pos.y].n +=1
		explode(Vector2(pos.x+1,pos.y))
		explode(Vector2(pos.x,pos.y+1))
		explode(Vector2(pos.x-1,pos.y))
		explode(Vector2(pos.x,pos.y-1))
		
		
	#Replace the visuals of the sphere to the current board_data values..
	replace_sphere(pos,board_data[pos.x][pos.y].n)
	
	pass
	
func replace_sphere(pos,num):
	
	if num == 0:
		var s = board_spheres[pos.x][pos.y]
		s.queue_free()
		
		s = single_sph.instance()
		$Spheres.add_child(s)
			
		s.translation = Vector3(pos.y+0.5,0.5,pos.x+0.5)
		s.hide()
		board_spheres[pos.x][pos.y] = s
		
	elif num == 1:
		if board_spheres[pos.x][pos.y] != null:
			board_spheres[pos.x][pos.y].show()
		else:
			var s = single_sph.instance()
			$Spheres.add_child(s)
		
			s.translation = Vector3(pos.y+0.5,0.5,pos.x+0.5)
			board_spheres[pos.x][pos.y] = s
			
	elif num == 2:
		if board_spheres[pos.x][pos.y] != null:
			var s = board_spheres[pos.x][pos.y]
			s.queue_free()
			s = two_sph.instance()
			$Spheres.add_child(s)
			
			s.translation = Vector3(pos.y+0.5,0.5,pos.x+0.5)
			
			board_spheres[pos.x][pos.y] = s
			
	elif num == 3:
		if board_spheres[pos.x][pos.y] != null:
			var s = board_spheres[pos.x][pos.y]
			s.queue_free()
			s = three_sph.instance()
			$Spheres.add_child(s)
			
			s.translation = Vector3(pos.y+0.5,0.5,pos.x+0.5)
			
			board_spheres[pos.x][pos.y] = s
			
	elif num == 4:
		if board_spheres[pos.x][pos.y] != null:
			var s = board_spheres[pos.x][pos.y]
			s.queue_free()
			s = four_sph.instance()
			$Spheres.add_child(s)
			
			s.translation = Vector3(pos.y+0.5,0.5,pos.x+0.5)
			
			board_spheres[pos.x][pos.y] = s
	pass
