#!usr/bin/python

#defines vector object

import math

class vector:
	v = []
	
	#constructor
	def __init__(self, a):
		self.v = a
		
	#instance methods
	def magnitude(self):
		sum = 0
		for i in range(len(self.v)):
			sum += self.v[i]^2
		return math.sqrt(sum)
		
	def multiply(self, factor):
		for i in self.v:
			i *= factor
		
	def unit(self):
		temp_vector = vector(self.v)
		mag = temp_vector.magnitude()
		temp_vector.multiply(1/mag)
		self.v = temp_vector.v
		
	#static methods
	#add two vectors
	@staticmethod
	def add(v1, v2):
		temp = vector(v1.v)
		for i in range(len(v1.v)):
			temp.v[i] = v1.v[i] + v2.v[i]
			
		return temp
	
	#difference
	@staticmethod
	def difference(v1, v2):
		difference = vector(v1.v)
		for i in range(len(v1.v)):
			difference.v[i] = v1.v[i] - v2.v[i]
			
		return difference
	#dot product
	@staticmethod
	def dot(v1, v2):
		dot = 0
		for i in range(len(v1.v)):
			dot += v1.v[i]*v2.v[i]
		return dot
	#cross product
	@staticmethod
	def cross(v1, v2):
		if len(v1)==3 and len(v2)==3:
			cross = vector([v1.v[1]*v2.v[2]-v1.v[2]*v2.v[1],
							v1.v[2]*v2.v[0]-v1.v[0]*v2.v[2],
							v1.v[0]*v2.v[1]-v1.v[1]*v2.v[0]])
			return cross
		else:
			print "both vectors must be of length 3 to be crossed."
			return vector([0,0,0])	
	#distance
	@staticmethod
	def distance(v1, v2):
		return vector.difference(v1, v2).magnitude()
		
	#print
	@staticmethod
	def printv(vec):
		print '{',
		for i in range(len(vec.v)):
			if i == len(vec.v)-1:
				print str(vec.v[i]),
			else:
				print str(vec.v[i]) + ',',
		print '}\n'
		
#v1 = vector([0,1,2])
#v2 = vector([-3,1,2])

#vector.printv(v1)
#vector.printv(v2)

#v1.multiply(3)
#print '2 magnitude: ' + str(v2.magnitude()) + '\n'
#v1.unit()
#vector.printv(v1)

#v3 = vector.add(v1, v2)
#vector.printv(v3)

#v4 = vector.difference(v1, v2)
#vector.printv(v4)

#print 'distance: ' + str(vector.distance(v3, v4)) + '\n'