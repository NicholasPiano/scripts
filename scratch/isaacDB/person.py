#!usr/bin/python3

class person:
	
	def __init__(self, first_name, last_name):
		self.first_name = first_name
		self.last_name = last_name
		
	def __str__(self):
		return self.first_name + ' ' + self.last_name