class Regression {
  List<double> x;
  List<double> y;
  int decimals = 2;
  Regression({required this.x, required this.y}) : super();

  double predict() {
    return 0.toDouble();
  }

  List<double> $predict() {
    return [0.toDouble()];
  }

  List<double> predictArray({required List<double> x}) {
    return [0.toDouble()];
  }

  String equation() {
    return '0';
  }

  String toLaTeX() {
    return '0';
  }
}
