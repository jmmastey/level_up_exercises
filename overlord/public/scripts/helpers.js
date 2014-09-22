function leading_zeros(number, length) {
  var s = number.toString();
  while (s.length < length) s = "0" + s;
  return s;
}
