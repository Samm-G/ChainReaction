extends ImmediateGeometry

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var upb = 0
var downb = 6
var leftb = 0
var rightb = 10

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	render_grid()
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func render_grid():
	
	self.begin(Mesh.PRIMITIVE_LINE_STRIP,null)
	
	# Horizontal Lines(First Layer..)
	
	for i in range(upb,downb+1):
		if i%2 == 0:
			self.add_vertex(Vector3(i,0,leftb))
			self.add_vertex(Vector3(i,0,rightb))
		else:
			self.add_vertex(Vector3(i,0,rightb))
			self.add_vertex(Vector3(i,0,leftb))
	
	for i in range(downb,upb-1,-1):
		if i%2 == 0:
			self.add_vertex(Vector3(i,0,leftb))
			self.add_vertex(Vector3(i,0,rightb))
		else:
			self.add_vertex(Vector3(i,0,rightb))
			self.add_vertex(Vector3(i,0,leftb))
		
	for i in range(leftb,rightb+1):
		if i%2 == 0:
			self.add_vertex(Vector3(upb,0,i))
			self.add_vertex(Vector3(downb,0,i))
		else:
			self.add_vertex(Vector3(downb,0,i))
			self.add_vertex(Vector3(upb,0,i))
			
	self.add_vertex(Vector3(upb,0,rightb))
	self.add_vertex(Vector3(upb,0,leftb))
	
	#Vertical Lines..
	for i in range(upb,downb+1):
		if i%2 == 0:
			self.add_vertex(Vector3(i,0,leftb))
			self.add_vertex(Vector3(i,1,leftb))
		else:
			self.add_vertex(Vector3(i,1,leftb))
			self.add_vertex(Vector3(i,0,leftb))
	
	for i in range(leftb,rightb+1):
		if i%2 == 0:
			self.add_vertex(Vector3(downb,0,i))
			self.add_vertex(Vector3(downb,1,i))
		else:
			self.add_vertex(Vector3(downb,1,i))
			self.add_vertex(Vector3(downb,0,i))
			
	for i in range(downb,upb-1,-1):
		if i%2 == 0:
			self.add_vertex(Vector3(i,0,rightb))
			self.add_vertex(Vector3(i,1,rightb))
		else:
			self.add_vertex(Vector3(i,1,rightb))
			self.add_vertex(Vector3(i,0,rightb))
			
	for i in range(rightb,leftb-1,-1):
		if i%2 == 0:
			self.add_vertex(Vector3(upb,0,i))
			self.add_vertex(Vector3(upb,1,i))
		else:
			self.add_vertex(Vector3(upb,1,i))
			self.add_vertex(Vector3(upb,0,i))
			
	#Horizontal Lines(2nd Layer)
	
	for i in range(upb,downb+1):
		if i%2 == 0:
			self.add_vertex(Vector3(i,1,leftb))
			self.add_vertex(Vector3(i,1,rightb))
		else:
			self.add_vertex(Vector3(i,1,rightb))
			self.add_vertex(Vector3(i,1,leftb))
	
	for i in range(downb,upb-1,-1):
		if i%2 == 0:
			self.add_vertex(Vector3(i,1,leftb))
			self.add_vertex(Vector3(i,1,rightb))
		else:
			self.add_vertex(Vector3(i,1,rightb))
			self.add_vertex(Vector3(i,1,leftb))
		
	for i in range(leftb,rightb+1):
		if i%2 == 0:
			self.add_vertex(Vector3(upb,1,i))
			self.add_vertex(Vector3(downb,1,i))
		else:
			self.add_vertex(Vector3(downb,1,i))
			self.add_vertex(Vector3(upb,1,i))
			
	
	#self.add_vertex(Vector3(-2,0,-6))
	self.end()
	
	
	pass
