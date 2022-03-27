import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helper/models/models.dart';
import 'package:helper/tools/tools.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../widgets/widgets.dart';

class LeastSquaresRegressionScreen extends StatefulWidget {
  const LeastSquaresRegressionScreen({Key? key}) : super(key: key);

  @override
  State<LeastSquaresRegressionScreen> createState() =>
      _LeastSquaresRegressionScreenState();
}

class _LeastSquaresRegressionScreenState
    extends State<LeastSquaresRegressionScreen> {
  String equation = '';
  String latex = '';
  String sdSlope = '';
  String sdIntercept = '';
  String slope = '';
  String intercept = '';
  String familyFont = 'Serif';
  int presicion = 3;
  List<double> prediction = [];
  final Map<String, String> formValues = {
    'x': '0, 2, 4, 6, 8, 10, 12',
    'y': '2.1, 5, 9, 12.6, 17.3, 21.0, 24.7',
  };

  List<Positions> getChart(List<List<double>> values) {
    final List<Positions> ListData = List.generate(values[0].length,
        (index) => Positions(values[0][index], values[1][index]));
    return ListData;
  }

  List<Positions> _listData = [];
  List<Positions> _predictionList = [];

  // final TextEditingController _textController = TextEditingController();

  Future<void> _copyToClipboard(String latex) async {
    await Clipboard.setData(ClipboardData(text: latex));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('LaTeX equation copied to clipboard'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    List<double> x = [0, 2, 4, 6, 8, 10, 12];
    List<double> y = [2.1, 5, 9, 12.6, 17.3, 21.0, 24.7];

    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text('Regresión lineal por mínimos cuadrados')),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: myFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Center(
                      child: Text('Especifique los vectores',
                          style:
                              TextStyle(fontSize: 30, fontFamily: familyFont))),
                  const SizedBox(height: 30),
                  CustomInputField(
                      // icon: Icons.play_arrow,
                      labelText: 'x axis',
                      hintText: 'x',
                      formProperty: 'x',
                      textInputType: TextInputType.number,
                      formValues: formValues),
                  CustomInputField(
                      // icon: Icons.play_arrow,
                      labelText: 'y axis',
                      hintText: 'y',
                      formProperty: 'y',
                      textInputType: TextInputType.number,
                      formValues: formValues),
                  Row(children: [
                    ElevatedButton(
                        child: const Text('Calcular'),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (!myFormKey.currentState!.validate()) {
                            return;
                          }
                          final x = formValues['x']!
                              .split(',')
                              .map(double.parse)
                              .toList();
                          final y = formValues['y']!
                              .split(',')
                              .map(double.parse)
                              .toList();

                          final xLength = x.length;
                          final yLength = y.length;
                          if (xLength != yLength) {
                            dialogAndroid(context, xLength, yLength);
                          } else {
                            _listData = getChart([x, y]);
                            final regression =
                                LeastSquaresRegression(x: x, y: y);
                            prediction = regression.predictArray(x: x);
                            _predictionList = getChart([x, prediction]);
                            equation = regression.equation();
                            sdSlope = regression
                                .getSDSlope()
                                .toStringAsPrecision(presicion);
                            slope = regression
                                .getSlope()
                                .toStringAsPrecision(presicion);
                            intercept = regression
                                .getIntercept()
                                .toStringAsPrecision(presicion);
                            sdIntercept = regression
                                .getSDIntercept()
                                .toStringAsPrecision(presicion);
                            latex = regression.equation();
                            formValues['x'] =
                                '$x'.replaceAll('[', "").replaceAll(']', "");
                            formValues['y'] =
                                '$y'.replaceAll('[', "").replaceAll(']', "");
                            setState(() {});
                          }
                        }),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: const Text('Limpiar'),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (!myFormKey.currentState!.validate()) {
                            return;
                          }

                          formValues['x'] = '';
                          formValues['y'] = '';
                          setState(() {});
                        }),
                  ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                  const SizedBox(height: 30),
                  const SizedBox(height: 20),
                  Center(
                      child: Text('Pendiente',
                          style:
                              TextStyle(fontSize: 0, fontFamily: familyFont))),
                  const SizedBox(height: 20),
                  Center(
                      child: Text(
                          'pendiente = ${slope} \u00B1 ${sdSlope} \nintercepto = ${intercept} \u00B1 ${sdIntercept}',
                          style:
                              TextStyle(fontSize: 25, fontFamily: familyFont))),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Center(
                          child: Text('Ecuación',
                              style: TextStyle(
                                  fontSize: 30, fontFamily: familyFont))),
                      IconButton(
                          onPressed: () {
                            _copyToClipboard(latex);
                          },
                          icon: const Icon(Icons.copy))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: Text(equation,
                          style:
                              TextStyle(fontSize: 35, fontFamily: familyFont))),
                  const SizedBox(height: 20),
                  SfCartesianChart(series: <ChartSeries>[
                    LineSeries<Positions, double>(
                        dataSource: _predictionList,
                        xValueMapper: (Positions position, _) => position.x,
                        yValueMapper: (Positions position, _) => position.y),
                    ScatterSeries(
                        dataSource: _listData,
                        xValueMapper: (dynamic position, _) => position.x,
                        yValueMapper: (dynamic position, _) => position.y),
                  ])
                ],
              ),
            ),
          ),
        ));
  }

  void dialogAndroid(BuildContext context, xLength, yLength) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Error'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_outlined, size: 60),
                const Text('Los vectores deberian tener la misma longitud'),
                Text('x tiene $xLength elementos'),
                Text('y tiene $yLength elementos'),
                const Text('Advertencia:'),
                const Text('(.) indica decimales'),
                const Text('(,) indica separación entre elementos')
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
