import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:helper/models/elements.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  State<TableScreen> createState() => _TableScreenState();
}

const groupPositions = [
  [0, 2, 10, 18, 36, 54, 86, null, null, null], // Alkalyne
  [null, 3, 11, 19, 37, 55, 87, null, null, null], // Alkaline Earth metals
  [null, null, null, 20, 38, 70, 102, null, 56, 88], // Transition Metals 1
  [null, null, null, 21, 39, 71, 103, null, 57, 89], // Transition Metals 2
  [null, null, null, 22, 40, 72, 104, null, 58, 90], // Transition Metals 3
  [null, null, null, 23, 41, 73, 105, null, 59, 91], // Transition Metals 4
  [null, null, null, 24, 42, 74, 106, null, 60, 92], // Transition Metals 5
  [null, null, null, 25, 43, 75, 107, null, 61, 93], // Transition Metals 6
  [null, null, null, 26, 44, 76, 108, null, 62, 94], // Transition Metals 7
  [null, null, null, 27, 45, 77, 109, null, 63, 95], // Transition Metals 8
  [null, null, null, 28, 46, 78, 110, null, 64, 96], // Transition Metals 9
  [null, null, null, 29, 47, 79, 111, null, 65, 97], // Transition Metals 10
  [null, 4, 12, 30, 48, 80, 112, null, 66, 98], // Group 3
  [null, 5, 13, 31, 49, 81, 113, null, 67, 99], // Group 4
  [null, 6, 14, 32, 50, 82, 114, null, 68, 100], // Group 5
  [null, 7, 15, 33, 51, 83, 115, null, 69, 101], // Group 6
  [null, 8, 16, 34, 52, 84, 116, null, null, null], // Halogens group
  [1, 9, 17, 35, 53, 85, 117, null, null, null] // Noble gas group
];

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    Future<List<Elements>> readJsonData() async {
      final jsondata =
          await rootBundle.loadString('assets/periodicTableSpanish.json');
      final list = json.decode(jsondata) as List<dynamic>;
      return list.map((e) => Elements.fromJson(e)).toList();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tabla periódica'),
        ),
        body: FutureBuilder(
          future: readJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text('${data.error}'));
            } else if (data.hasData) {
              var items = data.data as List<Elements>;
              return ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                      child: Text('Tabla periódica',
                          style: TextStyle(
                              fontSize: 60, fontFamily: 'RyujinAttack'))),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    height: 900.0,
                    child: ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        for (int i = 0; i < groupPositions.length; i++)
                          Period(items: items, group: groupPositions[i])
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: ElevatedButton(
            // style: ElevatedButton.styleFrom(
            //     primary: AppTheme.primary,
            //     shape: const StadiumBorder(),
            //     elevation: 10),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Compact view',
                style: TextStyle(fontSize: 20, fontFamily: 'RyujinAttack'),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'compact');
            }));
  }
}

class Period extends StatelessWidget {
  const Period({
    Key? key,
    required this.items,
    required this.group,
    this.width = 70,
  }) : super(key: key);

  final List<Elements> items;
  final List<dynamic> group;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: TableElement(items: items, index: group[index]),
          );
        }),
      ),
    );
  }
}

class TableElement extends StatelessWidget {
  const TableElement({
    Key? key,
    required this.items,
    this.index,
  }) : super(key: key);

  final List<Elements> items;
  final dynamic index;

  @override
  Widget build(BuildContext context) {
    if (index != null) {
      return SizedBox(
          child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.white)),
        height: 60.0,
        minWidth: 60.0,
        color: Color(items[index].color),
        textColor: Colors.white,
        child: Column(
          children: [
            SizedBox(
                child: Text('${items[index].atomicNumber}',
                    style: TextStyle(fontSize: 10)),
                height: 10),
            SizedBox(
                child: Text('${items[index].symbol}',
                    style: TextStyle(fontSize: 25))),
          ],
        ),
        onPressed: () => {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  elevation: 5,
                  title: Center(
                    child: Text('${items[index].symbol}',
                        style: const TextStyle(fontSize: 90)),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "Número atomico : ${items[index].atomicNumber} \n Nombre: ${items[index].element} \n Tipo: ${items[index].type} \n Masa Atómica: ${items[index].atomicMass} \n Estado: ${items[index].phase}"),
                      const SizedBox(height: 10)
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Listo, ya entendí')),
                  ],
                );
              })
        },
        splashColor: Colors.redAccent,
      ));
    } else {
      return const SizedBox(
        child: Text(''),
        height: 60.0,
      );
    }
  }
}
