// // implementation in Dart of Robust polynomial regression using LMedS.
// // https://github.com/mljs/regression-robust-polynomial

// import 'dart:math';

// import 'package:periodic_table/tools/utilities/utilities.dart';
// import 'package:periodic_table/tools/polinomial/utils/get_random_tuples.dart';

// class RobustPolynomialRegression {
//   List<double> x;
//   List<double> y;
//   int degree;
//   double? b;
//   double? e;
//   double? syx;
//   int decimals = 2;
//   RobustPolynomialRegression(
//       {required this.x, required this.y, required this.degree}) {
//     checkData(x, y);
//     List<double> powers = List.generate(degree, (index) => index.toDouble());
//     final tuples = getRandomTuples(x, y, degree);

//     dynamic min = null;
//     for (dynamic tuple in tuples) {
//     const coefficients = calcCoefficients(tuple, powers);
//     const residuals: { residual: number; coefficients: number[] }[] = [];
//     for (let j = 0; j < x.length; j++) {
//       const residual = y[j] - predict(x[j], powers, coefficients);
//       residuals[j] = {
//         residual: residual * residual,
//         coefficients,
//       };
//     }

//     let median = residualsMedian(residuals);
//     if (!min || median.residual < min.residual) {
//       min = median;
//     }
//   }
//   regression.degree = degree;
//   regression.powers = powers;
//   regression.coefficients = min ? min.coefficients : [];
//   }

//   List<double> predict() {
//     final List<double> yPredicted = [];
//     final nbPoints = x.length;
//     double syy = 0;
//     for (int i = 0; i < nbPoints; i++) {
//       final value = b! * exp(x[i] * e!);
//       yPredicted.add(roundTo(value, decimals));
//       syy += pow(y[i] - value, 2);
//     }
//     syx = sqrt(syy / (nbPoints - 2));
//     return yPredicted;
//   }

//   List<double> predictFromData({required List<double> x}) {
//     final List<double> yPredicted = [];
//     for (int i = 0; i < x.length; i++) {
//       final value = b! * exp(x[i] * e!);
//       yPredicted.add(value);
//     }
//     return yPredicted;
//   }

//   String getEquation() {
//     final equation = 'f(x) = $b * e^${e}x';
//     return equation;
//   }
// }
