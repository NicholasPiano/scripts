ones = ['<ruleref uri=\"Digits.xml#Zero\"/>', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
tens = ['twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']

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
        ret.append(' '.join(expanded_list[::-1]))
  else:
    ret = ' '.join(expanded_list[::-1])
    was_expanded = False
  return (ret, was_expanded)

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
          translation.append([tens[int(char)-2], ones[int(char)]])
        else:
          translation.append(ones[int(char)])
        number = False
      else:
        translation.append(ones[int(char)])
        number = True

  return expand(translation)[0]

print(translate('YYB06Q'))
