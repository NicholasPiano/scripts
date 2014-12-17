ones = {'0':'<ruleref uri=\"Digits.xml#Zero\"/>','1':'one','2':'two','3':'three','4':'four','5':'five','6':'six','7':'seven','8':'eight','9':'nine'}
teens = dict(ones.items() + {'1':'eleven','2':'twelve','3':'thir','5':'fif','8':'eigh'}.items())
tens = dict(teens.items() + {'2':'twen','4':'for'}.items())

def number_to_string(number_string):
  '''
  Converts a two digit string into a number in English with a couple exceptions:
  1. If the first character is '0', the string reads 'zero <number>'
  2. If the string is '10', it reads 'one zero'
  '''

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
        output = (char, tens[char]+('ty' if char!='0' else ''))

      string.append(output)
      ten = not ten

  else:
    for char in number_string[::-1]:
      string.append((char, ones[char]))

  return ' '.join([lm[1] for lm in string[::-1]])

def translate(string, pattern):
  #pairs of numbers should be translated as tens or teens
  #unless the group of number is greater than four.
  pair = False
  number = False
  for i, char in enumerate(pattern[::-1]):
    print(char)


  ['L','NNNN','LLL','NN','L','NNNNN']
  ['L','NN','NN','L','L','L','N','N','L','N','N','N','N','N']




translate('L9034YYB06Q89451','LNNNNLLLNNLNNNNN')
