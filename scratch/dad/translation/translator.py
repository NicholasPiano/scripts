#!usr/bin/python

import re
import sys

file = sys.argv[1]
input_f = open(file, "r")
lines = []
i = 0

while input_f:
    line = input_f.readline() #single string
    #apply regexes
    lines.append(re.sub(r'\{', '[', line))
    ++i
for l in lines:
    print l
