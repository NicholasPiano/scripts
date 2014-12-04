'''
Created on 18 May 2012

@author: nicholas
'''
import math

class vector(object):
    v = []

    def __init__(self, a):
        self.v = a

    def magnitude(self):
        temp_sum = sum(i*i for i in self.v)
        return math.sqrt(temp_sum)
    
    def multiply(self, factor):
        for i in range(len(self.v)):
            self.v[i] *= factor
    
    def unit(self):
        b = self.magnitude()
        self.multiply(1.0/b)

    #static methods
    @staticmethod
    def add(a, b):
        c = vector([])
        for i in range(len(a.v)):
            c.v.append(a.v[i] + b.v[i])
        return c
    
    @staticmethod
    def subtract(a, b):
        c = vector([])
        for i in range(len(a.v)):
            c.v.append(a.v[i] - b.v[i])
        return c
    
    @staticmethod
    def dot(a, b):
        return sum(a.v[i]*b.v[i] for i in range(len(a.v)))
    
    @staticmethod
    def distance(a, b):
        return vector.subtract(a, b).magnitude()
    
    @staticmethod
    def cross(a, b):
        if len(a.v)*len(b.v) == 9:
            return vector([a.v[1]*b.v[2] - a.v[2]*b.v[1],
                            a.v[2]*b.v[0] - a.v[0]*b.v[2],
                            a.v[0]*b.v[1] - a.v[1]*b.v[0]])
        else:
            return vector([])
    
    @staticmethod
    def printv(a):
        print '{',
        for i in range(len(a.v)):
            if i == len(a.v)-1:
                print str(a.v[i]),
            else:
                print str(a.v[i]) + ',',
        print '}'
        