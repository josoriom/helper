import 'dart:math';

double roundTo(double number, int decimals) {
  final power = pow(10, decimals);
  final numerator = number * power;
  return (numerator.round() / power);
}
