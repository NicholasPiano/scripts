#!usr/bin/python3

# ****************************************************************************************
# ****************************************************************************************
#   Copyright 2013 Nicholas Piano.  All rights reserved.
#   This is an unpublished work of Nicholas Piano and is not to be
#   used or disclosed except as provided in a license agreement or
#   nondisclosure agreement with Nicholas Piano.
# ****************************************************************************************
# ****************************************************************************************

#script to calculate optimum position for a number of arbitrarily shaped boxed when packed into a certain area.

#objects for box, field, and algorithm
#methods to run algorithm and return properties of box arrangement
#file output

########### TODO ##########
#1. problems testing points inside box face
#2. need a way to test face area
#3. all face tests
#4. face: make faces
###########################

#all vectors are in three dimensions
from vector import vector, dot, add, multiply, distance

#field class
class field: ####################### F I E L D ##########################
	def __init__(self, x, y, z):
		self.shape_vector = vector([x, y, z])
		self.volume = x*y*z
		self.box_list = []
		self.vertex_list = []
		self.mass = None
		self.centre_of_mass = None
		self.centre_of_volume = None

	#tests
	def com_change(self, b): #return change in height of com: temporary test function
		h = (self.mass*self.centre_of_mass + box.mass*box.centre.z)/(self.mass + box.mass)
		return (h - centre_of_mass)
	def cov_change(self, b): #return dot +/- change in position of cov: temporary test function
		c = self.centre_of_volume.v #current centre of volume array
		a = b.centre.v #box centre array
		d = []
		for i in range(len(a)):
			d[i] = (c[i]-a[i])/2.0
		change = vector(d)
		return dot(change, c)
	def test_26(self, v): #input single vertex
		a = [] #array of results
		for x in range(-1, 1):
			for y in range(-1, 1):
				for z in range(-1, 1):
					v = vector([x/1000.0,y/1000.0,z/1000.0]) #units: metres
					a[x+1][y+1][z+1] = self.test_inside(vertex(difference(self.pv, v)))
		return a
	def test_inside(self, v): #input vertex
		boxes = self.box_list
		a = []
		for i in range(len(boxes)):
			if boxes[i].test_point(v.pv) == 0:
				a.append(i)
		return a
	def test_bottom(self, b): #is bottom completely covered? return 0
		if dot(b.primary_vector, vector(0, 0, 1)) != 0:
			s = 0
			for i in range(len(self.box_list)):
				s += b.faces[0].test_contact(self.box_list[i].faces[3])
			if s == b.faces[0].area:
				return 0
			else:
				return 1
		else:
			return 0
	#getters and setters
	def set_mass(self, boxes): #sum over all boxes
		mass = 0
		for i in range(len(boxes)):
			mass += boxes[i].mass
		self.mass = mass
	def get_mass(self):
		return self.mass

	#properties
	mass = property(get_mass, set_mass) #scalar
			
class box: ########################### B O X #############################
	def __init__(self, x, y, z, mass, name):
		self.volume = x*y*z
		self.x = x
		self.y = y
		self.z = z
		self.mass = mass
		self.vertices = vertex.make_vertices_box([x, y, z])
		self.faces = face.make_faces(self.vertices)
		self.centre = vertex.make_centre(self.vertices)
		self.parameter = vertex.make_parameter(self.vertices)
		self.primary_vector = None
	
	#tests and actions
	def test_intersect(self, b): #one box overlaps another: return 0
		v1 = self.vertices
		v2 = b.vertices
		i = 0
		test1 = 1
		test2 = 1
		while test1 != 0 and test2 != 0:
			test1 = b.test_point(v1[i].pv)
			test2 = self.test_point(v2[i].pv)
			i += 1
		return test1
	def test_point(self, v): #input vector, point inside box?: return 0
		s = vertex.make_sum(self.vertices, v)
		if s < self.parameter:
			return 0
		else:
			return 1
	def rotate(self, index): #faces take turns to face towards -x
		a = [self.x, self.y, self.z]
		b = [[a[0], a[1], a[2]], [a[0], a[2], a[1]], [a[1], a[0], a[2]]]

	def test_shortest_centre(self):
		a = []
		for i in range(len(self.faces)):
			self.rotate(i)
			a.append(self.centre.magnitude())
		a.sort()
		return a[0]
		
	#synthesise - add declarations
	def set_pv(self, pv):
		self.primary_vector = pv
	def get_pv(self):
		return self.primary_vector
	def set_faces(self, faces):
		self.faces = faces
	def get_faces(self):
		return self.faces
	def set_centre(self, centre):
		self.centre = centre
	def get_centre(self):
		return self.centre
	
	#properties
	primary_vector = property(get_pv, set_pv)
	faces = property(get_faces, set_faces)
	centre = property(get_centre, set_centre)
	
class face: ######################### F A C E #############################
	def __init__(self, x, y, index, primary_vector, name):
		self.x = x
		self.y = y
		self.area = x*y
		self.vertices = vertex.make_vertices_face(x, y, index)
		self.centre = vertex.make_centre(self.vertices)
		self.parameter = vertex.make_parameter(self.vertices)
		self.pv = primary_vector #shouldnt change
	
	#tests
	def test_contact(self, f): #return area covered
		#which vertices are inside each face?
		for i in range(len(self.vertices)):
			self.test_point(f.vertices[i].pv)
			face.test_point(self.vertices[i].pv)
		#what are their x and y coordinates?
		#return area made by their differences
	def test_point(self, vector): #inside or on edge
		pass

	#setters and getters
	def set_v(self, v):
		self.vertices = v
	def get_v(self):
		return self.vertices

	@staticmethod
	def make_faces(vertex_array):
		pass #implement initialiser from Face.java
	
	#properties
	vertices = property(get_v, set_v)
	
class vertex: ##################### V E R T E X ########################
	def __init__(self, primary_array):
		self.pv = vector(primary_array)
	
	@staticmethod
	def make_vertices_box(a): #return array of vertex objects
		x = a[0]
		y = a[1]
		z = a[2]
		v = [vertex([0,0,0]), #origin
			 vertex([x,0,0]), vertex([0,y,0]), vertex([0,0,z]), #first plane
			 vertex([x,y,0]), vertex([x,0,z]), vertex([0,y,z]), #second plane
			 vertex([x,y,z])] #antipode
		return v
	@staticmethod
	def make_vertices_face(x, y, i):
		v = [vertex([0,0,0]), vertex([x,0,0]), vertex([y,0,0]), vertex([x,y,0])]
		if i==0:
			pass
		if i==1:
			v[1] = vertex([0,0,x])
			v[3] = vertex([0,y,x])
		if i==2:
			v[2] = vertex([0,0,y])
			v[3] = vertex([x,0,y])
		return v
	@staticmethod
	def make_centre(v): #input array of vertices, return vector location of centre
		a = multiply(v[(len(v)-1)].pv, 0.5)
		return add(a, v[0].pv)
	@staticmethod
	def make_sum(v, vec): #input array of vertices and vector
		s = 0
		for i in range(len(v)):
			s += distance(v.pv, vec)
		return s
	@staticmethod
	def make_parameter(v): #input array of vertices
		parameter = 0
		for i in range(len(v)):
			parameter += v[i].pv.magnitude()
		return parameter
		
f = field(1,2,3)
b = box(1,1,1,1.2,box)
f.box_list.append(b)

		
#algorithm
	#choose best box
		#choose heaviest, biggest boxes first
	#find suitable places
		#compile list of 1,2,3 vertices not occupied by 0 vertices.
			#test: eliminate common elements
		#eliminate spaces with insufficient space
			#test: scalar field of height in field, run along to find increases and decreases
			#compile mini-map over box area
		#minimize
	#minimize
		#minimize distance to chosen corner, if there is competition within margin of error:
			#minimize vertical placement of centre of mass