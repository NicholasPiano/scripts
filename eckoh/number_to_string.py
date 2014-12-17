ones = {'0':'<ruleref uri=\"Digits.xml#Zero\"/>','1':'one','2':'two','3':'three','4':'four','5':'five','6':'six','7':'seven','8':'eight','9':'nine'}
teens = dict(ones.items() + {'1':'eleven','2':'twelve','3':'thir','5':'fif','8':'eigh'}.items())
tens = dict(teens.items() + {'2':'twen','4':'for'}.items())

def number_to_string(number_string):
  string = []

  if len(number_string)<4:
    ten = False
    for char in number_string[::-1]:
      teen = ten and char=='1'

      output = (char, ones[char])

      if teen:
        last_char = string[-1][0]
        if last_char!='0': #not zero
          string = []
          output = (last_char, teens[last_char]+('teen' if last_char not in ['1','2'] else ''))

      elif ten:
        last_char = string[-1][0]
        if last_char=='0':
          string = []
        output = (char, tens[char]+'ty')

      string.append(output)
      ten = not ten

  else:
    for char in number_string[::-1]:
      string.append((char, ones[char]))

  return ' '.join([lm[1] for lm in string[::-1]])

for i in range(100):
  print(number_to_string(str(i)))
