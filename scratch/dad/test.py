#!usr/bin/python

import re

string = 'hello I can see you'

test = re.search("I", string)

print str(test)
