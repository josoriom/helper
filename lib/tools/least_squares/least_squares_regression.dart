import 'dart:math';

import 'package:helper/tools/utilities/utilities.dart';
import 'package:helper/tools/regression/regression.dart';

class LeastSquaresRegression extends Regression {
  List<double> x;
  List<double> y;
  double? sxx;
  double? syx;
  double? xMean;
  double? yMean;
  double? slope;
  double? sdSlope;
  double? intercept;
  double? sdIntercept;
  int decimals = 2;
  LeastSquaresRegression({required this.x, required this.y})
      : super(x: x, y: y) {
    checkData(x, y);
    x = x;
    y = y;
    final nbPoints = x.length;
    double sxx = 0;
    double sxy = 0;
    double xMean = x.reduce((a, b) => (a + b)) / nbPoints;
    double yMean = y.reduce((a, b) => (a + b)) / nbPoints;
    for (int i = 0; i < nbPoints; i++) {
      sxx += pow(x[i] - xMean, 2);
      sxy += (x[i] - xMean) * (y[i] - yMean);
    }
    this.sxx = sxx;
    final slope = sxy / sxx;
    this.slope = slope;
    final intercept = yMean - slope * xMean;
    this.intercept = intercept;
  }

  @override
  List<double> predictArray({required List<double> x}) {
    final List<double> yPredicted = [];
    if (slope == null || intercept == null) throw Error();
    for (int i = 0; i < x.length; i++) {
      final value = slope! * x[i] + intercept!;
      yPredicted.add(value);
    }
    return yPredicted;
  }

  @override
  List<double> $predict() {
    final List<double> yPredicted = [];
    final nbPoints = x.length;
    double syy = 0;
    for (int i = 0; i < nbPoints; i++) {
      final value = slope! * x[i] + intercept!;
      yPredicted.add(roundTo(value, decimals));
      syy += pow(y[i] - value, 2);
    }
    syx = sqrt(syy / (nbPoints - 2));
    return yPredicted;
  }

  @override
  String equation() {
    final slope = getSlope();
    final intercept = getIntercept();
    final equation =
        'f(x) = ${slope.toStringAsPrecision(decimals)}x + ${intercept.toStringAsPrecision(decimals)}';
    return equation;
  }

  @override
  String toLaTeX() {
    return 'f(x)=${slope!.toStringAsPrecision(decimals)}x+${intercept!.toStringAsPrecision(decimals)}';
  }

  double getSlope() {
    if (slope == null) throw Error();
    return slope!;
  }

  double getIntercept() {
    if (intercept == null) throw Error();
    return intercept!;
  }

  double getSDSlope() {
    $predict();
    double sdSlope = syx! / sqrt(sxx!);
    return sdSlope;
  }

  double getSDIntercept() {
    $predict();
    final nx = x.map((e) => pow(e, 2)).reduce((a, b) => a + b);
    double sdIntercept = syx! * sqrt(nx / (x.length * sxx!));
    return sdIntercept;
  }
}
