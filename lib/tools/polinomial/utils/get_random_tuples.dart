import 'dart:math';

List<List<Map<String, double>>> getRandomTuples(
    List<double> x, List<double> y, int degree) {
  int length = (x.length ~/ degree).floor();
  List<List<Map<String, double>>> tuples = List.generate(length, (index) => []);

  for (int i = 0; i < x.length; i++) {
    int pos = (Random().nextDouble() * length).floor();

    int counter = 0;
    while (counter < x.length) {
      dynamic val = tuples[pos];
      if (!val) {
        tuples[pos] = [
          {'x': x[i], 'y': y[i]}
        ];
        break;
      } else if (val.length < degree) {
        tuples[pos].add({
          'x': x[i],
          'y': y[i],
        });
        break;
      } else {
        counter++;
        pos = (pos + 1) % length;
      }
    }
  }
  return tuples;
}
