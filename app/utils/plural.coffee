@plural = (number, one, two, five) ->
  number = Math.abs(number) % 100
  return five if number >= 5 and number <= 20
  number %= 10
  return one if number is 1
  return two if number >= 2 and number <= 4
  five

@adjective = (number, one, two) ->
  number %= 100
  return two if number is 11
  number %= 10
  return one if number is 1
  two
