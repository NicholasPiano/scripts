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
		sum1 = 0
		for i in range(len(self.v)):
			sum1 += self.v[i]^2
		return math.sqrt(sum1)

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
	def __str__(self):
		print '{',
		for i in range(len(self.v)):
			if i == len(self.v)-1:
				print str(self.v[i]),
			else:
				print str(self.v[i]) + ',',
		print '}\n'