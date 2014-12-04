#!usr/bin/python

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
		z += [int(bool(e[j]))]

	a = ' and ' if sum(z)==1 and z[2]==1 and i==length-1 and i!=0 else ''
	
	if e[1]==1:
		string = ones[e[0]] + z[0]*(' hundred' + int(bool(z[2]) or bool(z[1]))*' and ') + teens[e[2]]
	else:
		string = ones[e[0]] + z[0]*(' hundred' + int(bool(z[2]) or bool(z[1]))*' and ') + tens[e[1]] + z[1]*'-' + a + ones[e[2]]
	
	#return string
	p = int(sum(z)!=0) #if all zeros no power ending
	b = ', ' if ((i!=length-1 and i!=0 and int(group)!=0) or (i==length-1 and z[0]!=0) or length!=1) else ''
	return b + string + p*(' ' + powers[length-1-i])

#input
inf = raw_input('Enter a number to be translated: ')

zero = 'zero' if int(inf)==0 else ''

#split up number into threes
threes_array = []
for dummy_index in range(len(inf)/3):
	if int(inf)!=0: threes_array += [inf[-3:]]
	inf = inf[:-3]

#rearrange things
inf = (3-len(inf))*'0' + inf
if int(inf)!=0: threes_array += [inf]
threes_array = threes_array[::-1]

#for each set of three, determine hundreds, tens and ones
complete_string = ''
for i in range(len(threes_array)):
	complete_string += tristring(i, threes_array[i], len(threes_array))
	
print(zero + complete_string)