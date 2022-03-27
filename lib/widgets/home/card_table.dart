import 'dart:ui';

import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  final List<Map<String, dynamic>> homeCards;
  const CardTable({Key? key, required this.homeCards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(children: [
      for (int i = 0; i < 2; i++)
        TableRow(children: [
          for (int j = 0; j < 2; j++)
            _SingleCard(
              color: homeCards[i + (i + 1 * j)]['color'],
              icon: homeCards[i + (i + 1 * j)]['icon'],
              text: homeCards[i + (i + 1 * j)]['name'],
              route: homeCards[i + (i + 1 * j)]['route'],
            )
        ])
    ]);
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String route;
  const _SingleCard(
      {Key? key,
      required this.icon,
      required this.color,
      required this.text,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(5, 76, 102, 1),
                  borderRadius: BorderRadius.circular(20)
                  // end
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: color,
                    child: Icon(icon, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    text,
                    style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
