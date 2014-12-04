#!usr/bin/python

#program to determine location and optimal movement for an articulated arm

import math

class arm:

	#location in 2D
	number_of_links = 0
	length = 0
	angles = []
	x_pos = 0
	y_pos = 0
	
	def __init__(self, number_of_links, length, angles):
		self.number_of_links = number_of_links
		self.length = length
		self.angles = angles + (number_of_links - len(angles))*[0]
		(self.x_pos, self.y_pos) = self.get_position()
	
	def get_position(self):
		link_angle = 0
		x = 0
		y = 0
		for i in range(self.number_of_links):
			link_angle += self.angles[i]
			x += math.cos(link_angle)
			y += math.sin(link_angle)
		return (x*self.length, y*self.length)
		
	def new_position(self, x_new, y_new):
		return 0
		#given old position, find shortest way to get to new position from inputs
		
a = arm(4, 1, [0, math.pi/4, math.pi/2, 1])
print(a.get_position())

asteroid mining - firing out a cable to asteroid

database of failures