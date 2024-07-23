import 'dart:io';

int calculate() {
  var dir = Directory("/home/easbarba/.config/onur");
  var fi = dir.list();
  fi.forEach((element) => print(element));

  return 6 * 7;
}
