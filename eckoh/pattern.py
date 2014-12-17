#picks patterns out from licence plate data

import re
import os
import random

#define pattern
letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

exclusion_threshold = 100
max_per_format = 50

class Licence(object):

  def __init__(self, input_string):
    self.string = input_string
    self.pattern = ''
    for char in input_string:
      if char.isalpha():
        self.pattern += 'L'
      else:
        self.pattern += 'N'

def strip(string):
  groups = string.split('\t')
  return groups[1]

def generate_with_pattern(pattern):
  string = ''
  for char in pattern:
    string += random.choice(letters) if char=='L' else str(random.randint(0,9))
  return string

ones = ['<ruleref uri=\"Digits.xml#Zero\"/>', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
teen = 'teen'

tens = ['twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']

def translate(string):
  translation = []
  number = False

  for char in string[::-1]:
    if char.isalpha():
      translation.append(char.lower())
      number = False
    else:
      if number:
        if int(char)>1:
          translation.append(tens[int(char)-2])
        else:
          translation.append(ones[int(char)])
        number = False
      else:
        translation.append(ones[int(char)])
        number = True

  return ' '.join(translation[::-1])

#input from data

licence_list = []
unique_patterns = []

uk = 'full_license_plate_list_filtered'
fo = 'fullForeignList'

with open(os.path.join(uk)) as f:
  lines = f.readlines()
  for i, line in enumerate(lines):
#    print((i, line, len(lines)))
    licence = Licence(line.rstrip())
    if licence.pattern not in unique_patterns:
      unique_patterns.append(licence.pattern)
    licence_list.append(licence)

with open(os.path.join(fo)) as f:
  lines = f.readlines()
  for i, line in enumerate(lines):
#    print((i, line, len(lines)))
    if licence.pattern not in unique_patterns:
      unique_patterns.append(licence.pattern)
    licence_list.append(licence)

#for each unique pattern, generate a random string that conforms to the pattern, but is not currently in the data set
#make 100 for each and save to output directory with the pattern as the filename.txt

gram_preamble = ''
gram_preamble += "<\?xml version=\"1.0\" encoding=\"ISO-8859-1\" \?>\n"
gram_preamble += "<!DOCTYPE grammar PUBLIC \"-//W3C//DTD GRAMMAR 1.0//EN\" \"http://www.w3.org/TR/speech-grammar/grammar.dtd\">\n"
gram_preamble += "<grammar xmlns=\"http://www.w3.org/2001/06/grammar\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n"
gram_preamble += "    xml:lang=\"en-GB\" version=\"1.0\" tag-format=\"swi-semantics/1.0\" root=\"DECOY\" >\n"
gram_preamble += "\n"
gram_preamble += "<lexicon uri=\"license_dict.xml\?SWI.type=backup\"/>\n"
gram_preamble += "\n"
gram_preamble += "<!-- grammar meta statements to set Nuance recogniser call logging parameters -->\n"
gram_preamble += "<meta name=\"swirec_company_name\" content=\"TFL\"/>\n"
gram_preamble += "<meta name=\"swirec_application_name\" content=\"TFL Congestion Charge\"/>\n"
gram_preamble += "\n"
gram_preamble += "<!--\n"
gram_preamble += "*\n"
gram_preamble += "* Project	: TFL Congestion Charge\n"
gram_preamble += "* Author	: Larry Piano\n"
gram_preamble += "* Date		: 20/10/2014\n"
gram_preamble += "* Release	: 0.1\n"
gram_preamble += "*\n"
gram_preamble += "* Copyright (c) 2014 ECKOH LIMITED (Company No. GB0033359141), \n"
gram_preamble += "* a company incorporated under the laws of the United Kingdom whose \n"
gram_preamble += "* registered office is at: Telford House, Corner Hall, Hemel Hempstead, Herts HP3 9HN, \n"
gram_preamble += "* United Kingdom. All rights reserved, worldwide.\n"
gram_preamble += "*\n"
gram_preamble += "* ECKOH LIMITED has intellectual property rights relating to\n"
gram_preamble += "* technology embodied in the software that is described in this \n"
gram_preamble += "* document. In particular, and without limitation, these intellectual \n"
gram_preamble += "* property rights may include one or more of patents or pending patent \n"
gram_preamble += "* applications in the U.K. and in other countries.\n"
gram_preamble += "*\n"
gram_preamble += "* Any licence granted by ECKOH LIMITED shall be non-exclusive and \n"
gram_preamble += "* shall not confer any proprietary rights in the software or any other \n"
gram_preamble += "* rights not expressly granted.  All title to, ownership of and all \n"
gram_preamble += "* copyright and other proprietary rights in the software shall at all \n"
gram_preamble += "* times, remain vested in ECKOH LIMITED.\n"
gram_preamble += "* \n"
gram_preamble += "* THIS SOURCE CODE CONTAINS CONFIDENTIAL INFORMATION AND TRADE SECRETS\n"
gram_preamble += "* OF ECKOH LIMITED. USE, DISCLOSURE OR REPRODUCTION IS PROHIBITED \n"
gram_preamble += "* WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF ECKOH LIMITED.\n"
gram_preamble += "*\n"
gram_preamble += "-->\n"
gram_preamble += "\n"

gram_preamble += "<rule id=\"DECOY\">\n"
gram_preamble += "\t<one-of>\n"

gram_postamble = ''
gram_postamble += "\t</one-of>\n"

gram_postamble += "</rule>\n\n"
gram_postamble += "</grammar>\n"

output_path = 'grammar'
if not os.path.exists(output_path): #creates output directory if necessary
  os.makedirs(output_path)

for pattern in unique_patterns:
  filter_method = lambda x: x.pattern==pattern
  data_set = filter(filter_method, licence_list)
  data = [l.string for l in data_set]
  frequency = len(data)
  if frequency >= exclusion_threshold:
    file_name = os.path.join(output_path, pattern+'_decoy.xml')
    print('pattern: %s above threshold (%d) with frequency %d, writing to %s'%(pattern, exclusion_threshold, frequency, file_name))
    decoy_set = []
    for i in range(max_per_format):
      test_decoy = generate_with_pattern(pattern)
      while ((test_decoy in data) or (test_decoy in decoy_set)):
        test_decoy = generate_with_pattern(pattern)
      decoy_set.append(test_decoy)

    with open(file_name, 'w') as f:
      f.write(gram_preamble)

      for decoy in decoy_set:
        line = '\t\t<item>%s<tag>VALUE="%s";</tag></item>\n'
        f.write(line%(translate(decoy), decoy))

      f.write(gram_postamble)
  else:
    print('pattern: %s below threshold (%d) with frequency %d, EXCLUDING'%(pattern, exclusion_threshold, frequency))
