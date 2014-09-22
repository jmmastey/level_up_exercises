function leading_zeros(number, length) {
  var s = number.toString();
  while (s.length < length) s = "0" + s;
  return s;
}

var Key = {
  enter: 13,
  backspace: 8,
  number_0: 48,
  number_9: 57,
  numpad_0: 96,
  numpad_9: 105
};
