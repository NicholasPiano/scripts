#picks patterns out from licence plate data

import re
import os
import random

#define pattern
letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
letter = re.compile(r'^[a-zA-Z]$')

class Licence(object):

  def __init__(self, input_string):
    self.string = input_string
    self.pattern = ''
    self.sequence = []
    for group in input_string.split(' '):
      for char in group:
        self.sequence.append(char)
        if re.search(letter, char) is not None:
          self.pattern += 'L'
        else:
          self.pattern += 'N'
      if len(input_string.split(' '))>1:
        self.pattern += 'S'
        self.sequence.append(' ')

def strip(string):
  groups = string.split('\t')
  return groups[1]

def generate_with_pattern(pattern):
  string = ''
  for char in pattern:
    string += random.choice(letters) if char=='L' else str(random.randint(0,9))
  return string

#input from data

licence_list = []
unique_patterns = []

uk = 'full_license_plate_list_filtered'
fo = 'fullForeignList'

with open(os.path.join(uk)) as f:
  lines = f.readlines()
  for i, line in enumerate(lines):
    print((i, line, len(lines)))
    licence = Licence(line.rstrip())
    if licence.pattern not in unique_patterns:
      unique_patterns.append(licence.pattern)
    licence_list.append(licence)

with open(os.path.join(fo)) as f:
  lines = f.readlines()
  for i, line in enumerate(lines):
    print((i, line, len(lines)))
    if licence.pattern not in unique_patterns:
      unique_patterns.append(licence.pattern)
    licence_list.append(licence)

print(unique_patterns)

#for each unique pattern, generate a random string that conforms to the pattern, but is not currently in the data set
#make 100 for each and save to output directory with the pattern as the filename.txt

#threshold
exclusion_threshold = 100 #patterns with a frequency less than this number are excluded

output_path = 'decoy'
if not os.path.exists(output_path): #creates output directory if necessary
  os.makedirs(output_path)

for pattern in unique_patterns:
  data_set = filter(lambda x: x.pattern==pattern, licence_list)
  data = [l.string for l in data_set]
  frequency = len(data)
  if frequency >= exclusion_threshold:
    file_name = os.path.join(output_path, pattern+'_%d.txt'%frequency)
    print('pattern: %s above threshold (%d) with frequency %d, writing to %s'%(pattern, threshold, frequency, file_name))
    decoy_set = []
    for i in range(100):
      test_decoy = generate_with_pattern(pattern)
      while test_decoy in data:
        test_decoy = generate_with_pattern(pattern)
      decoy_set.append(test_decoy)

    with open(file_name, 'w') as f:
      for decoy in decoy_set:
        f.write(decoy + '\n')
  else:
    print('pattern: %s above threshold (%d) with frequency %d, EXCLUDING'%(pattern, threshold, frequency))
