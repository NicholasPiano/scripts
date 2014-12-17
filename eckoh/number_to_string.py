ones = {'0':'<ruleref uri=\"Digits.xml#Zero\"/>','1':'one','2':'two','3':'three','4':'four','5':'five','6':'six','7':'seven','8':'eight','9':'nine'}
teens = dict(ones.items() + {'0':'ten','1':'eleven','2':'twelve','3':'thir','5':'fif','8':'eigh'}.items())
tens = dict(teens.items() + {'2':'twen','4':'for'}.items())

def expand(array):
  ret = []
  l = [2 if type(lm).__name__=='list' else 1 for lm in array]
  was_expanded = True
  if 2 in l:
    for option in array[l.index(2)]:
      sub_list = list(array)
      sub_list[l.index(2)] = option
      expanded_list, expanded = expand(sub_list)
      if expanded:
        ret.extend(expanded_list)
      else:
        ret.append(expanded_list)
  else:
    ret = ' '.join(array[::-1])
    was_expanded = False
  return (ret, was_expanded)

def number_to_string(number_string):
  string = []

  def two_string(ten, one):
    together = ones[one] if ten!='1' else (teens[one] + ('teen' if int(one)>2 else ''))
    apart = ones[ten] + ' ' + ones[one]

    if ten!='1':
      if ten=='0':
        together = ones[ten] + ' ' + together
      else:
        together = tens[ten] + 'ty' + ((' ' + together) if one!='0' else '')
    return [together, apart]

  if len(number_string)==1:
    string.append(ones[number_string])
  elif len(number_string)==2:
    ten, one = tuple(number_string)
    string.append(two_string(ten, one))
  elif len(number_string)==3:
    hundred, ten, one = tuple(number_string)
    string.extend([ones[hundred], two_string(ten, one)])
  else:
    for char in number_string[::-1]:
      string.append(ones[char])

  return expand(string[::-1])

for i in range(120):
  print(number_to_string(str(i)))
