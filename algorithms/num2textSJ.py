def main():

	start = 1000*1000 - 100
	end = 1000*1000 + 200

	for n in range(start, end):
		r = num2text(n)
		print n, ' = ', r


def num2text(n):

	if type(n) != int: return 'ERROR: n must be an integer'

	if n < 0: return 'NOT POSITIVE'
	if n > 10 ** 33: return 'TOO BIG'

	if n == 0: return 'zero'
	
	terms = ['', 'thousand', 'million', 'billion', 'trillion', 'quadrillion', 
		'quintillion', 'sextillion', 'septillion', 'octillion', 'nonillion', 'decillion']

	groups = convertNumberToGroupsOfThreeDigits(n)
	numberOfGroups = len(groups)
	
	r = ''

	for i in range(numberOfGroups):
		term = terms[numberOfGroups - i - 1]
		group = groups[i]

		# last group prefix
		if numberOfGroups > 1:
			if sum(group) > 0:
				if i == numberOfGroups - 1:
					digit1 = group[0]
					if digit1 == 0:
						r += ' and '
					else:
						r += ', '

		# middle groups prefix
		if numberOfGroups > 2:
			if sum(group) > 0:
				if i > 0 and i < numberOfGroups - 1:
					r += ', '

		if i == numberOfGroups - 1: lastGroup = True
		else: lastGroup = False

		r += groupOfThree2text(group, lastGroup)
		if sum(group) > 0: r += ' ' + term

	return r


def groupOfThree2text(group, lastGroup):
	basic = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
	teens = ['eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 
		'seventeen', 'eighteen', 'nineteen']
	tens = ['ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']

	digit1, digit2, digit3 = group
	
	zeros = [bool(digit1), bool(digit2), bool(digit3)]

	if zeros == [0,0,0]:
		r = ''

	if zeros == [0,0,1]:
		r = basic[digit3]

	if zeros == [0,1,0]:
		r = tens[digit2 - 1]

	if zeros == [0,1,1]:
		foo = digit2 * 10 + digit3
		if 10 < foo and foo < 20:
			r = teens[foo - 10 - 1]
		else:
			r = tens[digit2 - 1] + '-' + basic[digit3]

	if zeros == [1,0,0]:
		r = basic[digit1] + ' hundred'
	
	if zeros == [1,0,1]:
		r = basic[digit1] + ' hundred' + ' ' + basic[digit3]
		if lastGroup: r = basic[digit1] + ' hundred' + ' and ' + basic[digit3]
	
	if zeros == [1,1,0]:
		r = basic[digit1] + ' hundred' + ' ' + tens[digit2 - 1]
		if lastGroup: r = basic[digit1] + ' hundred' + ' and ' + tens[digit2 - 1]
	
	if zeros == [1,1,1]:
		r = basic[digit1] + ' hundred'

		if lastGroup: r += ' and' 		

		foo = digit2 * 10 + digit3
		if 10 < foo and foo < 20:
			r += ' ' + teens[foo - 10 - 1]
		else:
			r += ' ' + tens[digit2 - 1] + '-' + basic[digit3]

	return r
		

def convertNumberToGroupsOfThreeDigits(n):
	n = str(n)
	digits = []
	for i in range(len(n)): digits.append(int(n[i]))
	groups = []
	while len(digits) > 2:
		lastThreeDigits = digits[-3:]
		digits = digits[:-3]
		groups.append(lastThreeDigits)
	if len(digits) > 0:
		while len(digits) < 3:
			digits.insert(0,0)
		groups.append(digits)
	groups.reverse()
	return groups
		
	



if __name__=='__main__': main()