#!usr/bin/python

print('Content-type: text/html\r\n\r')

#Number to word translator

#dictionaries
ones = ['','one','two','three','four','five','six','seven','eight','nine']
tens = ['','','twenty','thirty','forty','fifty','sixty','seventy','eighty','ninety']
teens = ['ten','eleven','twelve','thirteen','fourteen','fifteen','sixteen','seventeen','eighteen','nineteen']
powers = ['','thousand','million','billion','trillion','quadrillion','quintillion','sextillion','septillion','octillion']

#methods
def tristring(i, group, length):
	e = [] #int represented by string in group
	z = [] #whether or not e[i] is non-zero
	for j in range(len(group)):
		e += [int(group[j])]
		z += [e[j]]
		if e[j] > 0: z[j] = 1
	
	if e[1]==1:
		string = ones[e[0]] + z[0]*' hundred ' + int(bool(z[0]) or bool(z[1]))*'and ' + teens[e[2]]
	else:
		string = ones[e[0]] + z[0]*' hundred ' + int(bool(z[0]) or bool(z[1]))*'and ' + tens[e[1]] + z[1]*' ' + ones[e[2]]
	
	#return string
	return string + ' ' + powers[length-1-i]

#input
inf = raw_input('Enter a number to be translated: ')

#split up number into threes
threes_array = []
for dummy_index in range(len(inf)/3):
	threes_array += [inf[-3:]]
	inf = inf[:-3]

#rearrange things
inf = (3-len(inf))*'0' + inf
if inf!='000': threes_array += [inf]
threes_array = threes_array[::-1]

#prints ['890','567','234','001']

#for each set of three, determine hundreds, tens and ones
complete_string = ''
for i in range(len(threes_array)):
	a = ''
	if i != len(threes_array)-1: a = ', '
	complete_string += tristring(i, threes_array[i], len(threes_array)) + a
	
print(complete_string)
	