.bubblechart {
  template: http://www.treesheets.org/widgets/bubblechart/bubblechart.html#chart;
  template-proxy: http://people.csail.mit.edu/eob/cts-util/fragment-proxy.php;
  data: .;
  with: bubblechart;
}

ul.bubblechains {
  repeat: children;
}

ul.bubblechains li span {
  value: name;
}

ul.bubblechains li table tbody {
  repeat: children;
}

ul.bubblechains li table tbody tr td:first-child {
  value: name;
}

ul.bubblechains li table tbody tr td:last-child {
  value: size;
}
