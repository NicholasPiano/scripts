ones = ['<ruleref uri=\"Digits.xml#Zero\"/>', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
teens = ['eleven','twelve','thirteen','fourteen','fifteen','sixteen','seventeen','eighteen','nineteen']
tens = ['twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']

def translate(string):
  translation = []
  number = False
  zero = False

  for char in string[::-1]:
    if char.isalpha():
      translation.append(char.lower())
      number = False
    else:
      if number:
        if int(char)>1:
          translation.append(tens[int(char)-2])
          if zero:
            zero = False

        else:
          translation.append(ones[int(char)])
        number = False
      else:
        translation.append(ones[int(char)])
        if char=='0':
          zero = True
        number = True

  return ' '.join(translation[::-1])

print(translate('YYB06Q','LLLNNL'))
