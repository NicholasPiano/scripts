#!usr/bin/python3

#program to test boolean algebra

from itertools import permutations as perm

def bool1(b):
	return (not b[0] and (b[1] or (b[2] and b[3]) or (not b[4] and b[5]))) or ((not b[6] or b[7]) and (not b[8] or b[9])) or (not b[10] and b[11])
	
def bool2(b):
	return not b[0] and b[1] or b[2] and b[3] or not b[4] and b[5] or not b[6] or b[7] and not b[8] or b[9] or not b[10] and b[11]
	
def permute(number):
	total = []
	for i in range(number):
		total.append(list(perm([True]*i + [False]*(number-i))))
	return total
	
combinations = permute(12)
for ar in combinations:
	for a in ar:
		tie = bool1(a)==bool2(a)
		if not tie:
			print a
		