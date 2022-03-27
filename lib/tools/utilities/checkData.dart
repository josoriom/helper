void checkData(x, y) {
  if (x is! List<double>) {
    throw Exception('X is not a list of double');
  }

  if (y is! List<double>) {
    throw Exception('Y is not a list of double');
  }

  if (x.length != y.length) {
    throw Exception('X and Y must have the same length');
  }
}
