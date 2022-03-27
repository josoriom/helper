import 'dart:math';

import 'package:helper/tools/least_squares/least_squares_regression.dart';
import 'package:helper/tools/regression/regression.dart';
import 'package:helper/tools/utilities/utilities.dart';

class ExponentialRegression extends Regression {
  List<double> x;
  List<double> y;
  double? b;
  double? e;
  double? syx;
  int decimals = 2;
  ExponentialRegression({required this.x, required this.y})
      : super(x: x, y: y) {
    checkData(x, y);
    x = x;
    y = y;
    final n = x.length;
    final List<double> yLog = [];
    for (int i = 0; i < n; i++) {
      yLog.add(log(y[i]));
    }
    final regression = LeastSquaresRegression(x: x, y: yLog);
    e = roundTo(regression.getSlope(), decimals);
    b = roundTo(exp(regression.getIntercept()), decimals);
  }

  List<double> $predict() {
    final List<double> yPredicted = [];
    final nbPoints = x.length;
    double syy = 0;
    for (int i = 0; i < nbPoints; i++) {
      final value = b! * exp(x[i] * e!);
      yPredicted.add(roundTo(value, decimals));
      syy += pow(y[i] - value, 2);
    }
    syx = sqrt(syy / (nbPoints - 2));
    return yPredicted;
  }

  Map<String, double> getData() {
    return {"b": b!, "e": e!};
  }

  String toLaTeX() {
    final equation =
        'f(x)=${b!.toStringAsPrecision(decimals)}e^{${e!.toStringAsPrecision(decimals)}x}';
    return equation;
  }

  List<double> predictArray({required List<double> x}) {
    final List<double> yPredicted = [];
    for (int i = 0; i < x.length; i++) {
      final value = b! * exp(x[i] * e!);
      yPredicted.add(value);
    }
    return yPredicted;
  }

  String equation() {
    final equation =
        'f(x) = ${b!.toStringAsPrecision(decimals)} * e^${e!.toStringAsPrecision(decimals)}x';
    return equation;
  }
}
